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
        @BindingState var isShowModify = false
        @BindingState var isShowDelete = false
        @BindingState var isShowAbout = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case showModify
        case showDelete(Bool)
        case showAbout
        case modifyAccount
        case deleteAccount
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .showModify:
                    state.isShowModify = true
                    return .none
                case let .showDelete(t):
                    state.isShowDelete = t
                    return .none
                case .showAbout:
                    state.isShowAbout = true
                    return .none
                case .modifyAccount:
                    
                    return .none
                    
                case .deleteAccount:
                    
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct SettingView: View {
    let store: StoreOf<Setting>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            Form {
                Section {
                    SettingRow(imgName: "person.circle", title: "头像", content: {
                        GeometryReader { geo in
                            Avatar(radius: geo.size.height / 2)
                        }.fixedSize(horizontal: true, vertical: false).padding(.trailing)
                    }){}
                    SettingRow(imgName: "person", title: "昵称", content: {Text("balabala")}){}
                    SettingRow(imgName: "signature", title: "签名", content: {Text("balabala")}){}
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
                        vStore.send(.showDelete(true))
                    }
                }.listRowBackground(Color(0xA9FDC0, 0.4))
                
                Section {
                    SettingRow(imgName: "exclamationmark.circle", title: "关于我们", content: {
                        Image(systemName: "chevron.forward")
                    }) {
                        vStore.send(.showAbout)
                    }
                }
            }.sheet(isPresented: vStore.binding(\.$isShowModify)) {
                ModifyView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }.alert(isPresented: vStore.binding(\.$isShowDelete)) {
                Alert(
                    title: Text("注销账号"),
                    message: Text("确定要注销账号吗"),
                    primaryButton: .default(
                        Text("Cancel"),
                        action: {
                            vStore.send(.showDelete(false))
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("OK"),
                        action: {
                            vStore.send(.deleteAccount)
                        }
                    )
                )
            }.sheet(isPresented: vStore.binding(\.$isShowAbout)) {
                AboutMe()
                    .presentationDragIndicator(.visible)
            }
        }
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ModifyView: View {
    var body: some View {
        Text("sadfasdfa")
    }
}

struct AboutMe: View {
    var body: some View {
        Text("About Me")
    }
}

struct SettingRow<Content> : View where Content: View{
    var imgName: String
    var title: String
    var content: () -> Content
    var onTap: () -> Void
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
