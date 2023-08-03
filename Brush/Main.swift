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
        var isLogin: Bool = false
        var route = Route.State()
        var login = Login.State()
        
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case route(Route.Action)
        case login(Login.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.route, action: /Action.route) { Route() }
        Scope(state: \.login, action: /Action.login) { Login() }
        
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .login(.enterInput(.loginSuccess)):
                    withAnimation(.interactiveSpring()) {
                        state.isLogin.toggle()
                    }
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
            if (vStore.isLogin) {
                RouteView(
                    store: store.scope(state: \.route, action: Main.Action.route)
                ).transition(.opacity)
            } else {
                LoginView(
                    store: store.scope(state: \.login, action: Main.Action.login)
                ).transition(.opacity)
            }
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
