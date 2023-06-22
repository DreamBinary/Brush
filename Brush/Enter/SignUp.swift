//
//  SignUp.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct SignUp: ReducerProtocol {
    struct State: Equatable {
        var enterInput = EnterInput.State(type: .SignUp)
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

        Reduce { _, action in
            switch action {
                case .enterInput, .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct SignUpView: View {
    let store: StoreOf<SignUp>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in

            ZStack(alignment: .bottom) {
                Image("SignUp")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hi There,\nHave an account!")
                        .font(.title.bold())
                    EnterInputView(
                        store: store.scope(state: \.enterInput, action: SignUp.Action.enterInput)
                    )
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
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(
            store: Store(
                initialState: SignUp.State(),
                reducer: SignUp()
            )
        )
    }
}
#endif
