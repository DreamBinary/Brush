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
    struct State: Equatable {}

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { _, action in
            switch action {
                case .binding:
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
                        store: Store(
                            initialState: EnterInput.State(),
                            reducer: EnterInput()
                        )
                    )
                    LoginWay()
                }
                .padding(.horizontal, 60)
                .padding(.bottom, 110)
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
