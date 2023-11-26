//
//  ModifyPassword.swift
//  Brush
//
//  Created by cxq on 2023/8/26.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct ModifyPassword: ReducerProtocol {
    struct State: Equatable {
        @BindingState var showToast: Bool = false
        var toastState: ToastState = .init()
        
        @BindingState var focus: Field?
        @BindingState var old: String = ""
        @BindingState var new: String = ""
        @BindingState var check: String = ""
        @BindingState var shakeOld: Bool = false
        @BindingState var shakeNew: Bool = false
        @BindingState var shakeCheck: Bool = false
        
        var buttonLoading = false
        
        enum Field: String, Hashable {
            case old, new, check
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onModifyBtnTap
        case modifyPassword
        case modifySuccess
        case modifyFail
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .onModifyBtnTap:
                    if state.old.isEmpty {
                        state.focus = .old
                        state.shakeOld = true
                    } else if state.new.isEmpty {
                        state.focus = .new
                        state.shakeNew = true
                    } else if state.check.isEmpty {
                        state.focus = .check
                        state.shakeCheck = true
                    } else if state.new != state.check {
                        state.focus = .check
                        state.shakeCheck = true
                    } else {
                        state.buttonLoading = true
                        state.focus = nil
                        return Effect.send(.modifyPassword)
                    }
                    return .none
                    
                case .modifyPassword:
                    if (DataUtil.getUser()?.id) != nil {
                        return .task { [old = state.old, new = state.new ] in
// todo
//                            let response: Response<Bool?> = try await ApiClient.request(Url.modifyPassword, method: .POST, params: ["id": userId, "oldPlainPassword": old, "newPlainPassword": new])
//                            if response.code == 200 && response.data == true {
//                                return .modifySuccess
//                            }
                            return .modifyFail
                        }
                    }
                    return Effect.send(.modifyFail)
                    
                case .modifySuccess:
                    state.buttonLoading = false
                    state.old = ""
                    state.new = ""
                    state.check = ""
                    return .none

                case .modifyFail:
                    state.buttonLoading = false
                    state.toastState.text = "修改密码失败"
                    state.toastState.toastType = .fail
                    state.showToast = true
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct ModifyPasswordView: View {
    let store: StoreOf<ModifyPassword>
 
    @FocusState private var focusedField: ModifyPassword.State.Field?
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            
            VStack {
                ModifyInput(tip: "现有密码", text: vStore.binding(\.$old))
                    .focused(self.$focusedField, equals: .old)
                    .shake(vStore.binding(\.$shakeOld))
                
                ModifyInput(tip: "新的密码", text: vStore.binding(\.$new))
                    .focused(self.$focusedField, equals: .new)
                    .shake(vStore.binding(\.$shakeNew))
                
                ModifyInput(tip: "再次输入", text: vStore.binding(\.$check))
                    .focused(self.$focusedField, equals: .check)
                    .shake(vStore.binding(\.$shakeCheck))
                
                LoginBtn(text: "修改密码", buttonLoading: vStore.buttonLoading) {
                    vStore.send(.onModifyBtnTap)
                }
            }.padding(.horizontal, 32)
                .synchronize(vStore.binding(\.$focus), self.$focusedField)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(0xA9FDC0, 0.4))
                .toast(showToast: vStore.binding(\.$showToast), toastState: vStore.toastState)
        }
    }
}

struct ModifyInput: View {
    var tip: String
    var text: Binding<String>
    let textFieldHeight: Double = 30
    @State private var isSecured: Bool = true
    var body: some View {
        HStack {
            Text(tip)
            PasswordInput(text: text, height: textFieldHeight)
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct ModifyPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPasswordView(
            store: Store(
                initialState: ModifyPassword.State(),
                reducer: ModifyPassword()
            )
        )
    }
}
#endif
