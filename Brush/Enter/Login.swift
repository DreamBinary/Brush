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
        var signUp = SignUp.State()
        var enterInput = EnterInput.State()
    }

    enum Action: BindableAction, Equatable {
        case signUp(SignUp.Action)
        case enterInput(EnterInput.Action)
        case binding(BindingAction<State>)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.enterInput, action: /Action.enterInput) {
            EnterInput()
        }

        BindingReducer()

        Reduce { _, action in
            switch action {
                case .signUp, .enterInput, .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct LoginView: View {
    let store: StoreOf<Login>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in

            ZStack(alignment: .bottom) {
                Image("Login")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hi There,\nWelcome back!")
                        .font(.title.bold())
                    EnterInputView(
                        store: store.scope(state: \.enterInput, action: Login.Action.enterInput)
                    )
                    
//                    NavigationLink(
//                        destination: IfLetStore(
//                            self.store.scope(
//                                state: \.signUp,
//                                action: Login.Action.signUp
//                            )
//                        ) {
//                            SignUpView(store: $0)
//                        } else: {
//                            ProgressView()
//                        },
//                        isActive: viewStore.binding(
//                            get: \.isNavigationActive,
//                            send: NavigateAndLoad.Action.setNavigation(isActive:)
//                        )
//                    ) {
//                        Text("Load optional counter")
//                    }
                    
                    EnterWay().padding(.vertical, 10)
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
