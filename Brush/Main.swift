//
//  Main.swift
//  Brush
//
//  Created by cxq on 2023/8/1.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Main: ReducerProtocol {
    struct State: Equatable {
        @BindingState var showToast: Bool = false
        var toastState: ToastState = .init()

        var isLogin: Bool = DataUtil.getLogin()
        var route = Route.State()
        var login = Login.State()
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case showToast
        case route(Route.Action)
        case login(Login.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.route, action: /Action.route) { Route() }
        Scope(state: \.login, action: /Action.login) { Login() }

        BindingReducer()
        Reduce { state, action in
            switch action {
                case .showToast:
                    state.showToast = true
                    return .none
                case let .login(.enterInput(.signUpFail(code))):
                    var msg: String = ""
                    if code == ErrorCode.badRequest.rawValue {
                        msg = ErrorCode.badRequest.message
                    } else if code == ErrorCode.invalidEmailFormat.rawValue {
                        msg = ErrorCode.invalidEmailFormat.message
                    } else if code == ErrorCode.emailAlreadyExists.rawValue {
                        msg = ErrorCode.emailAlreadyExists.message
                    } else if code == ErrorCode.registrationFailed.rawValue {
                        msg = ErrorCode.registrationFailed.message
                    } else {
                        msg = ErrorCode.otherError.message
                    }
                    state.toastState.text = msg
                    state.toastState.toastType = .fail
                    return Effect.send(.showToast)
                case .login(.enterInput(.signUpSuccess)):
                    state.toastState.text = SuccessMessage.register.rawValue
                    state.toastState.toastType = .success
                    return Effect.send(.showToast)
                case .login(.enterInput(.loginSuccess)):
                    withAnimation(.interactiveSpring()) {
                        state.isLogin.toggle()
                    }
                    state.toastState.text = SuccessMessage.login.rawValue
                    state.toastState.toastType = .success
                    DataUtil.setLogin()
                    return Effect.send(.showToast)
                    
                // TODO
                case let .login(.enterInput(.loginFail(code))):
                    var msg: String = ""
                    
                    state.toastState.text = msg
                    state.toastState.toastType = .fail
                    return .none
                    
                case .route(.mine(.logout)):
                    state.isLogin = false
                    state.route = Route.State()
                    state.login = Login.State()
                    return .none
                case .binding, .route, .login:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct MainView: View {
    let store: StoreOf<Main>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            Group {
                if vStore.isLogin {
                    RouteView(
                        store: store.scope(state: \.route, action: Main.Action.route)
                    ).transition(.opacity)
                } else {
                    LoginView(
                        store: store.scope(state: \.login, action: Main.Action.login)
                    ).transition(.opacity)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .toast(showToast: vStore.binding(\.$showToast), toastState: vStore.toastState)
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: Main.State(),
                reducer: Main()
            )
        )
    }
}
#endif
