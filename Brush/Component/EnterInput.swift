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
        //        var isSecured: Bool = true
        enum Field: String, Hashable {
            case username, password
        }
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case signInTapped
        case changeType
        //        case secureChange
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
                case .signInTapped:
                    if state.username.isEmpty {
                        state.focus = .username
                    } else if state.password.isEmpty {
                        state.focus = .password
                    }
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
    @State var isSecured: Bool = true
    @State var isBtnDisabled: Bool = false
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            VStack {
                TextField("Enter Email", text: vStore.binding(\.$username))
                    .frame(height: self.textFieldHeight)
                    .font(.callout)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(0xA1D6CD, 0.26))
                    .cornerRadius(5)
                    .focused(self.$focusedField, equals: .username)

                ZStack(alignment: .trailing) {
                    Group {
                        if self.isSecured {
                            SecureField("Password", text: vStore.binding(\.$password)).frame(height: self.textFieldHeight)
                        } else {
                            TextField("Password", text: vStore.binding(\.$password)).frame(height: self.textFieldHeight)
                        }
                    }.font(.callout)
                        .padding(.trailing, 32)
                        .focused(self.$focusedField, equals: .password)
                    Button(action: {
                        self.isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                }.padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(0xA1D6CD, 0.26))
                    .cornerRadius(5)

                HStack {
                    Spacer()
                    Button {
                        vStore.send(.changeType)
                        self.isBtnDisabled = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            self.isBtnDisabled = false
                        }
                    } label: {
                        Text(vStore.type == .SignUp ? "Log in" : "Sign Up")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }.disabled(self.isBtnDisabled)
                }
                Button(action: {
                    vStore.send(.signInTapped)

                }, label: {
                    Text(vStore.type == .Login ? "Log in" : "Sign Up")
                        .bold()
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }).buttonStyle(RoundedAndShadowButtonStyle(foregroundColor: Color(0x084A5E), backgroundColor: Color(0x99EADC, 0.64), cornerRadius: 5))
                    .frame(height: self.textFieldHeight * 2)

            }.synchronize(vStore.binding(\.$focus), self.$focusedField)
        }
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
