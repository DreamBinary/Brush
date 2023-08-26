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
        case showAbout
        case deleteAccount
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

                case .deleteAccount:
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
                    let user: User = DataUtil.getUser() ?? User()
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
                        vStore.send(.showAbout)
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
                            vStore.send(.deleteAccount)
                        }
                    )
                )
            }
            .sheet(isPresented: vStore.binding(\.$isShowAbout)) {
                AboutMe()
                    .presentationDragIndicator(.visible)
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

struct AboutMe: View {
    var body: some View {
        Text("About Me")
    }
}

struct SettingRow<Content>: View where Content: View {
    var imgName: String
    var title: String
    var content: () -> Content
    var onTap: () -> Void = {}
    var body: some View {
        Button(action: onTap, label: {
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
        })
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
