//
//  Setting.swift
//  Brush
//
//  Created by cxq on 2023/8/22.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Setting: ReducerProtocol {
    struct State: Equatable {
        @BindingState var name: String
        @BindingState var label: String
        @BindingState var isShowModify = false
        @BindingState var isShowDelete = false
        @BindingState var isShowCourse = false
        @BindingState var isShowAbout = false

        @BindingState var showToast: Bool = false
        var toastState: ToastState = .init()

        var modifyPassword = ModifyPassword.State()

        init() {
            let user = DataUtil.getUser()
            self.name = user?.username ?? "Worsh"
            self.label = user?.signature ?? "I want BRIGHT smile"
        }
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case modifyPassword(ModifyPassword.Action)
        case disSetting
        case showModify
        case showDelete
        case showCourse
        case showAbout
        case logout
        case logoutSuccess
        case logoutFail
        case onDisappear
        case updateUser
        case updateSuccess
        case updateFail
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.modifyPassword, action: /Action.modifyPassword) { ModifyPassword() }
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .disSetting:
                    return .none
                case .showModify:
                    state.isShowModify = true
                    return .none
                case .showDelete:
                    state.isShowDelete = true
                    return .none
                case .showAbout:
                    state.isShowAbout = true
                    return .none
                case .showCourse:
                    state.isShowCourse = true
                    return .none
                case .logout:
                    if let userId = DataUtil.getUser()?.id {
                        return .task {
                            let response: Response<Bool?> = try await ApiClient.logout(Url.logout, param: userId)
                            if response.code == 200 && response.data == true {
                                return .logoutSuccess
                            }
                            return .logoutFail
                        }
                    }
                    return Effect.send(.logoutFail)
                    
                case .logoutSuccess:
                    DataUtil.removeAll()
                    return .none
                    
                case .logoutFail:
                    state.toastState.text = "注销失败"
                    state.toastState.toastType = .fail
                    state.showToast = true
                    return .none
                case .onDisappear:
                    return Effect.send(.updateUser)
                case .updateUser:
                    if let userId = DataUtil.getUser()?.id {
                        return .task { [username = state.name, signature = state.label] in
                            let response: Response<Bool?> = try await ApiClient.request(Url.updateUser, method: .POST, params: ["username": username, "signature": signature, "id": userId])
                            if response.code == 200 && response.data == true {
                                return .updateSuccess
                            }
                            return .updateFail
                        }
                    }
                    return .none

                case .updateSuccess:
                    var user: User = DataUtil.getUser() ?? User()
                    user.username = state.name
                    user.signature = state.label
                    DataUtil.saveUser(user)
                    return .none

                case .updateFail:
                    let user = DataUtil.getUser()
                    state.name = user?.username ?? "Worsh"
                    state.label = user?.signature ?? "I want BRIGHT smile"
                    return .none
                case .modifyPassword(.modifySuccess):
                    state.isShowModify = false
                    state.toastState.text = "成功修改密码"
                    state.toastState.toastType = .success
                    state.showToast = true
                    return .none
                case .binding, .modifyPassword:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct SettingView: View {
    let store: StoreOf<Setting>
    @FocusState private var focu: Field?

    enum Field {
        case name
        case label
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            Form {
                Section {
                    Text("Setting")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }.onTapGesture {
                    vStore.send(.disSetting)
                }
                Section {
                    SettingRow(imgName: "person.circle", title: "头像", content: {
                        GeometryReader { geo in
                            Avatar(radius: geo.size.height / 2)
                        }.fixedSize(horizontal: true, vertical: false).padding(.trailing)
                    })
                    SettingRow(imgName: "person", title: "昵称", content: {
                        TextField("", text: vStore.binding(\.$name), prompt: Text("昵称"))
                            .focused($focu, equals: .name)
                            .fixedSize()
                    })

                    SettingRow(imgName: "signature", title: "签名", content: {
                        TextField("", text: vStore.binding(\.$label), prompt: Text("签名"))
                            .focused($focu, equals: .label)
                            .fixedSize()
                    })
                }.listRowBackground(Color(0xA9C1FD, 0.6))

                Section {
                    SettingRow(imgName: "pencil.line", title: "修改密码", content: {
                        Image(systemName: "chevron.forward")
                    }) {
                        vStore.send(.showModify)
                    }
                    SettingRow(imgName: "eraser.line.dashed", title: "注销账号", content: {
                        Image(systemName: "chevron.forward")
                    }) {
                        vStore.send(.showDelete)
                    }
                }.listRowBackground(Color(0xA9FDC0, 0.4))

                Section {
                    SettingRow(imgName: "bookmark", title: "TuneBrush 教程", content: {
                        Image(systemName: "chevron.forward")
                    }) {
                        vStore.send(.showCourse)
                    }
                }.listRowBackground(Color(0xA0D6E5, 0.4))

                Section {
                    SettingRow(imgName: "exclamationmark.circle", title: "关于我们", content: {
                        Image(systemName: "chevron.forward")
                    }) {
                        vStore.send(.showAbout)
                    }
                }
            }.sheet(isPresented: vStore.binding(\.$isShowModify)) {
                ModifyPasswordView(
                    store: self.store.scope(state: \.modifyPassword, action: Setting.Action.modifyPassword)
                ).presentationDetents([.height(250)])
                    .presentationDragIndicator(.visible)
            }.alert(isPresented: vStore.binding(\.$isShowDelete)) {
                Alert(
                    title: Text("注销账号"),
                    message: Text("确定要注销账号吗"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(
                        Text("OK"),
                        action: {
                            vStore.send(.logout)
                        }
                    )
                )
            }
            .sheet(isPresented: vStore.binding(\.$isShowCourse)) {
                Course()
                    .presentationDetents([.large]).presentationDragIndicator(.visible)
            }
            .sheet(isPresented: vStore.binding(\.$isShowAbout)) {
                AboutMe()
                    .presentationDetents([.medium]).presentationDragIndicator(.visible)
            }
            .onTapGesture {
                focu = nil
            }
            .toast(showToast: vStore.binding(\.$showToast), toastState: vStore.toastState)
            .onDisappear {
                vStore.send(.onDisappear)
            }
//            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
//                print(focusedField)
//                print("TextField is now focused")
//            }
//            .onChange(of: focusedField) { next in
//                print(focusedField)
//                print(next)
//
//            }
        }
    }
}

struct Course: View {
    var body: some View {
        TabView {
            CourseOnePage(index: 1, title: "连接 Apple Watch", content: "TuneBrush需要连接您的Apple Watch来获取您更精确的刷牙信息,给您更真实的科学刷牙反 馈,为您提供更沉浸的音乐交互体验")
            CourseOnePage(index: 2,title: "分片区刷牙", content: "按照美国soidhqowh协会科学刷牙依据,每颗牙来回刷动7~8次能够较好地起到清洁效果,TuneBrush将您的牙齿划分别按照左右上下,颊侧面、舌侧面和咬合面12个片区")
            CourseOnePage(index: 3,title: "鼓点引导", content: "每个片区会有一段音乐，可以根据 Apple Watch 震动引导刷动规定音乐鼓点")
            CourseOnePage(index: 4, title: "切换提示", content: "在完成当前片区之后,TuneBrush 会为您提供片区切换的提示")
            CourseOnePage(index: 5, title: "刷牙评分", content: "12 个片区全都完成之后,TuneBrush 将会为您反馈本次刷牙评分,让您更好地养成科学刷牙习惯")
        }.tabViewStyle(.page(indexDisplayMode: .always))
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct CourseOnePage: View {
    let index: Int
    let title: String
    let content: String
    
    private let backgroundColors: [Color] = [
        Color(0x7DE2D1, 1),
        Color(0x9BEADC, 0.69),
        Color(0xCAFBF3, 1),
        Color(0xBAFEF3, 0.52),
        Color(0xDBFFF9, 0.25),
        Color.bgWhite
    ]
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            VStack {
                Spacer()
                Image("Course\(index)")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical)
                    .frame(width: width * 0.9)
                
                VStack(alignment: .leading, spacing: 8) {
                        Text("\(index) ")
                            .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                        + Text(title)
                            .font(.title)
                    Text(content)
                        .font(.body)
                        .lineSpacing(4)
                }.padding(.horizontal)
                    .fontWeight(.semibold)
                    .foregroundColor(.fontBlack)
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .bottom, endPoint: .top)
            )
        }
    }
}




struct AboutMe: View {
    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.all, 8)
            Text("TuneBrush")
                .font(.title)
                .bold()
            Text("Version 1.0.0")
                .font(.body)
            Spacer()
            VStack(spacing: 4) {
                Text("牙牙守护者 版权所有")
                Text("Copyright ©️ 2023 TuneBrush-Team.")
                Text("All Rights Reserved.")
            }.font(.caption2)
                .foregroundColor(.fontGray)
        }
    }
}

struct SettingRow<Content>: View where Content: View {
    var imgName: String
    var title: String
    var content: () -> Content
    var onTap: () -> Void = {}
    var body: some View {
        HStack {
            Image(systemName: imgName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.trailing, 5)
            Text(title)
            Spacer()
            content().foregroundColor(.fontGray)
        }.foregroundColor(.black)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap()
            }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(
            store: Store(
                initialState: Setting.State(),
                reducer: Setting()
            )
        )
    }
}
#endif
