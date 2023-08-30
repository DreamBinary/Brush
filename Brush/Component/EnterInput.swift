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
        @BindingState var username: String = "tunebrush@shawnxixi.icu"
        @BindingState var password: String = "qqqqqq"
        @BindingState var shakeUsername: Bool = false
        @BindingState var shakePassword: Bool = false
        @BindingState var shakeAggrement: Bool = false
        @BindingState var isAgree: Bool = false
        
        var buttonLoading = false
        
        enum Field: String, Hashable {
            case username, password
        }
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case changeType
        case signupTapped
        case loginTapped
        case loginSuccess(User)
        case loginFail(Int)
        case signUpFail(Int)
        case signUpSuccess
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
                case .signupTapped:
                    if state.username.isEmpty {
                        state.shakeUsername = true
                        state.focus = .username
                    } else if !self.isValidEmail(email: state.username) {
                        state.shakeUsername = true
                        state.focus = .username
                    } else if state.password.isEmpty {
                        state.shakePassword = true
                        state.focus = .password
                    } else if !state.isAgree {
                        state.shakeAggrement = true
                    } else {
                        state.buttonLoading = true
                        return .task { [email = state.username, password = state.password] in
                            let response: Response<User?> = try await ApiClient.request(Url.signUp, method: .POST, params: ["email": email, "password": password])
                            return response.code == 200 ? .signUpSuccess : .signUpFail(response.code ?? -1)
                        }
                    }
                    return .none

                case .loginTapped:
                    if state.username.isEmpty {
                        state.shakeUsername = true
                        state.focus = .username
                    } else if !self.isValidEmail(email: state.username) {
                        state.shakeUsername = true
                        state.focus = .username
                    } else if state.password.isEmpty {
                        state.shakePassword = true
                        state.focus = .password
                    } else {
                        state.buttonLoading = true
                        return .task { [email = state.username, password = state.password] in
                            let response: Response<User?> = try await ApiClient.request(Url.login, method: .POST, params: ["email": email, "plainPassword": password])
                            
                            return response.code == 200 ? .loginSuccess(response.data!!) : .loginFail(response.code ?? -1)
                        }
                    }
                    return .none
                    
                case let .loginSuccess(user):
                    state.buttonLoading = false
                    DataUtil.saveUser(user)
              
                    return .none
                case .loginFail(_):
                    state.buttonLoading = false
                    return .none
                case .signUpFail(_):
                    state.buttonLoading = false
                    return .none
                case .signUpSuccess:
                    state.buttonLoading = false
                    return Effect.send(.changeType)
                    
                case .changeType:
                    if state.type == .Login {
                        state.type = .SignUp
                    } else {
                        state.type = .Login
                    }
                    return .none
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

// MARK: - Feature view

struct EnterInputView: View {
    let textFieldHeight: Double = 30
    
    let store: StoreOf<EnterInput>
    
    @FocusState private var focusedField: EnterInput.State.Field?
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            VStack {
                UsernameInput(text: vStore.binding(\.$username), height: self.textFieldHeight)
                    .focused(self.$focusedField, equals: .username)
                    .shake(vStore.binding(\.$shakeUsername))
                PasswordInput(text: vStore.binding(\.$password), height: self.textFieldHeight)
                    .focused(self.$focusedField, equals: .password)
                    .shake(vStore.binding(\.$shakePassword))
                SignUpBtn(text: vStore.type == .SignUp ? "Log in" : "Sign Up", onTap: {
                    vStore.send(.changeType)
                })
                if vStore.type != .Login {
                    AggrementView(isAgree: vStore.binding(\.$isAgree))
                        .shake(vStore.binding(\.$shakeAggrement))
                        .frame(width: UIScreen.main.bounds.width).padding(.top, 4)
                }
                LoginBtn(text: vStore.type == .Login ? "Log in" : "Sign Up", buttonLoading: vStore.buttonLoading, onTap: {
                    vStore.send(vStore.type == .Login ? .loginTapped : .signupTapped)
                })
                .frame(height: self.textFieldHeight * 2)
            }.synchronize(vStore.binding(\.$focus), self.$focusedField)
                .animation(.easeInOut(duration: 0.5), value: vStore.type)
                
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
    var body: some View {
        HStack {
            Spacer()
            Button {
                self.onTap()
            } label: {
                Text(self.text)
                    .font(.caption)
                    .foregroundColor(.gray)
            }.padding(.trailing, 5)
        }
    }
}

struct LoginBtn: View {
    var text: String
    var buttonLoading: Bool
    
    var onTap: () -> Void
    var body: some View {
        Button(action: self.onTap, label: {
            HStack {
                if self.buttonLoading {
                    ProgressView()
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                } else {
                    Text(self.text)
                        .bold()
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
            }
        }).buttonStyle(RoundedAndShadowButtonStyle(foregroundColor: Color(0x084A5E), backgroundColor: Color(0x99EADC, 0.64), cornerRadius: 5))
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
