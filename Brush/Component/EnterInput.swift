//
//  LoginInput.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import ComposableArchitecture
import SwiftUI
import Moya

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
        
        @BindingState var shakeUsername:Bool = false
        @BindingState var shakePassword:Bool = false
        @BindingState var shakeAggrement:Bool = false
        @BindingState var isAgree:Bool = false
        
        var buttonLoading = false
        
        enum Field: String, Hashable {
            case username, password
        }
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case signupTapped
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
                case .signupTapped:
                    if state.username.isEmpty{
                        state.shakeUsername=true
                        state.focus = .username
                    } else if !isValidEmail(email: state.username){
                        state.shakeUsername=true
                        state.focus = .username
                    }else if state.password.isEmpty{
                        state.shakePassword=true
                        state.focus = .password
                    }else if !state.isAgree{
                        state.shakeAggrement=true
                    }else{
                        state.buttonLoading=true
                        let provider = MoyaProvider<ApiService>()
                        provider.request(.signUp(email:state.username,password:state.password)) { result in
                            switch result {
                            case let .success(res):
                                do {
                                    let response = try Response<String>(res: res.data)
                                    let code = response.code ?? -1
                                    var msg:String = ""
                                    if code == ErrorCode.badRequest.rawValue {
                                           msg = ErrorCode.badRequest.message
                                       } else if code == ErrorCode.invalidEmailFormat.rawValue {
                                           msg = ErrorCode.invalidEmailFormat.message
                                       } else if code == ErrorCode.emailAlreadyExists.rawValue {
                                           msg = ErrorCode.emailAlreadyExists.message
                                       } else if code == ErrorCode.registrationFailed.rawValue {
                                           msg = ErrorCode.registrationFailed.message
                                       } else if code == 200 {
                                           // 注册成功
                                           msg = SuccessMessage.register.rawValue
                                       }
                                     print(code)
                                    print(msg)

                                } catch {
                                    // TODO: 数据解析错误处理
                                    print("Error creating Response")
                                }
                            case let .failure(err):
                                // TODO: 接口请求错误处理
                                print(err)
                                break
                            }
                        }
                        
                        //return Effect.send(.changeType)
                        return .none

                    }
                return .none
                case .changeType:
                    if state.type == .Login {
                        state.type = .SignUp
                    } else {
                        state.type = .Login
                    }
                    return .none

                case .loginTapped:
                    if state.username.isEmpty {
                        state.shakeUsername=true
                        state.focus = .username
                    } else if state.password.isEmpty {
                        state.shakePassword=true
                        state.focus = .password
                    } else {
                        // 发起登录请求
//                        let provider = MoyaProvider<ApiService>()
//                        provider.request(.login(email:state.username,password:state.password)) { result in
//                            switch result {
//                            case let .success(res):
//                                do {
//                                    let response = try Response<User>(res: res.data)
////                                    let msg=response.message!
////                                    let code = response.code!
//                                    let data = response.data!
//                                    print(data.id)
//                                } catch {
//                                    // 处理错误
//                                    print("Error creating Response<User>: \(error)")
//                                }
//                            case .failure(_): break
//                                // TODO: handle the error == best. comment. ever.
//                            }
//                        }
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
    
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
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
                    .shake(vStore.binding(\.$shakeUsername))
                PasswordInput(text: vStore.binding(\.$password), height: self.textFieldHeight)
                    .focused(self.$focusedField, equals: .password)
                    .shake(vStore.binding(\.$shakePassword))
                SignUpBtn(text: vStore.type == .SignUp ? "Log in" : "Sign Up", onTap: {
                    vStore.send(.changeType)
                })
                if (vStore.type != .Login){
                    AggrementView(isAgree:vStore.binding(\.$isAgree))
                        .shake(vStore.binding(\.$shakeAggrement)).frame(width: UIScreen.main.bounds.width).padding(.top,4)
                }
                LoginBtn(text: vStore.type == .Login ? "Log in" : "Sign Up",buttonLoading: vStore.buttonLoading, onTap: {
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
    var buttonLoading : Bool
    
    var onTap: () -> Void
    var body: some View {
        Button(action: self.onTap, label: {
            HStack{
                if buttonLoading{
                    ProgressView()
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                else {
                    Text(self.text)
                        .bold()
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
            }
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
