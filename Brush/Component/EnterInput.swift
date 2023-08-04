//
//  LoginInput.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct EnterInput: ReducerProtocol {
    enum InputType {
        case Login
        case SignUp
    }

    struct State: Equatable {
        var type: InputType = .Login
        @BindingState var focus: Field?
        @BindingState var username: String = ""
        @BindingState var password: String = ""
        enum Field: String, Hashable {
            case username, password
        }
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case loginTapped
        case loginSuccess(User)
        case loginFail
        case changeType
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
                case .changeType:
                    if state.type == .Login {
                        state.type = .SignUp
                    } else {
                        state.type = .Login
                    }
                    return .none

                case .loginTapped:
                    // TODO: signup tap
                    if state.username.isEmpty {
                        state.focus = .username
                    } else if state.password.isEmpty {
                        state.focus = .password
                    } else {
                        // TODO: use moya ?
                        return .task { [email = state.username, plainPassword = state.password] in
                            let u: User? = try await ApiClient.request(Url.login, method: .POST, params: ["email": email, "plainPassword": plainPassword])
                            return u == .none ? .loginFail : .loginSuccess(u!)
                        }
                    }
                    return .none

                case let .loginSuccess(user):
                    DataUtil.saveUser(user)
                    return .none

                case .loginFail:
                    // TODO: fail fallback
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct EnterInputView: View {
    let textFieldHeight: Double = 30

    let store: StoreOf<EnterInput>

    @FocusState var focusedField: EnterInput.State.Field?

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            VStack {
                UsernameInput(text: vStore.binding(\.$username), height: self.textFieldHeight)
                    .focused(self.$focusedField, equals: .username)
                PasswordInput(text: vStore.binding(\.$password), height: self.textFieldHeight)
                    .focused(self.$focusedField, equals: .password)
                SignUpBtn(text: vStore.type == .SignUp ? "Log in" : "Sign Up", onTap: {
                    vStore.send(.changeType)
                })
                LoginBtn(text: vStore.type == .Login ? "Log in" : "Sign Up", onTap: { vStore.send(.loginTapped)
                })
                .frame(height: self.textFieldHeight * 2)

            }.synchronize(vStore.binding(\.$focus), self.$focusedField)
        }
    }
}

struct UsernameInput: View {
    var text: Binding<String>
    var height: Double
    var body: some View {
        TextField("Enter Email", text: self.text)
            .frame(height: self.height)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(0xA1D6CD, 0.26))
            .cornerRadius(5)
    }
}

struct PasswordInput: View {
    var text: Binding<String>
    var height: Double
    @State private var isSecured: Bool = true
    var body: some View {
        HStack {
            if self.isSecured {
                SecureField("Password", text: self.text).frame(height: self.height)
            } else {
                TextField("Password", text: self.text).frame(height: self.height)
            }
            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                .resizable()
                .scaledToFit()
                .accentColor(.gray)
                .frame(height: self.height * 0.5)
                .onTapGesture {
                    self.isSecured.toggle()
                }
        }.frame(height: self.height)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color(0xA1D6CD, 0.26))
            .cornerRadius(5)
    }
}

struct SignUpBtn: View {
    var text: String
    var onTap: () -> Void
    @State private var isBtnDisabled: Bool = false
    var body: some View {
        HStack {
            Spacer()
            Button {
                self.onTap()
                self.isBtnDisabled = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.isBtnDisabled = false
                }
            } label: {
                Text(self.text)
                    .font(.caption)
                    .foregroundColor(.gray)
            }.padding(.trailing, 5)
                .disabled(self.isBtnDisabled)
        }
    }
}

struct LoginBtn: View {
    var text: String
    var onTap: () -> Void
    var body: some View {
        Button(action: self.onTap, label: {
            Text(self.text)
                .bold()
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }).buttonStyle(RoundedAndShadowButtonStyle(foregroundColor: Color(0x084A5E), backgroundColor: Color(0x99EADC, 0.64), cornerRadius: 5))
    }
}

// 具体实现是通过在视图上注册两个 onChange 的方法来实现的。第一个 onChange 方法监听 first 的变化，并将变化的值赋值给 second；第二个 onChange 方法监听 second 的变化，并将变化的值赋值给 first。
extension View {
    func synchronize<Value>(
        _ first: Binding<Value>,
        _ second: FocusState<Value>.Binding
    ) -> some View {
        self
            .onChange(of: first.wrappedValue) { second.wrappedValue = $0 }
            .onChange(of: second.wrappedValue) { first.wrappedValue = $0 }
    }
}

// MARK: - SwiftUI previews

// #if DEBUG
// struct EnterInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterInputView(
//            store: Store(
//                initialState: EnterInput.State(),
//                reducer: EnterInput()
//            )
//        )
//    }
// }
// #endif
