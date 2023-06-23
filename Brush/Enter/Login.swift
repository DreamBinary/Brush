//
//  Login.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Login: ReducerProtocol {
    struct State: Equatable {
        var isLogin = true
        var enterInput = EnterInput.State()
    }

    enum Action: BindableAction, Equatable {
        case enterInput(EnterInput.Action)
        case binding(BindingAction<State>)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.enterInput, action: /Action.enterInput) {
            EnterInput()
        }
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .enterInput(.changeType):
                    withAnimation(.interactiveSpring()) {
                        state.isLogin.toggle()
                    }
                    return .none
                case .enterInput, .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct LoginView: View {
    let store: StoreOf<Login>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in

            ZStack(alignment: .bottom) {
                Image(vStore.isLogin ? "Login" : "SignUp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 12) {
                    Text(vStore.isLogin
                        ? "Hi There,\nWelcome back!"
                        : "Hi There,\nHave an account!"
                    ).font(.title.bold())
                    EnterInputView(
                        store: store.scope(state: \.enterInput, action: Login.Action.enterInput)
                    )
                    EnterWay()
                        .padding(.vertical, 10)
                }
                .padding(.horizontal, 60)
                .padding(.bottom, 100)
            }
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: Login.State(),
                reducer: Login()
            )
        )
    }
}
#endif
