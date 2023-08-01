////
////  Home.swift
////  Brush
////
////  Created by cxq on 2023/6/21.
////
//
//import ComposableArchitecture
//import SwiftUI
//
//
//// MARK: - Feature domain
//
//struct Home: ReducerProtocol {
//
//    struct State: Equatable {
//
//
//    }
//
//    enum Action: BindableAction, Equatable {
//        case binding(BindingAction<State>)
//
//    }
//
//    var body: some ReducerProtocol<State, Action> {
//        BindingReducer()
//        Reduce { state, action in
//            switch action {
//
//                case .binding:
//                    return .none
//            }
//        }
//    }
//}
//
//// MARK: - Feature view
//
//struct HomeView: View {
//    let store: StoreOf<Home>
//
//    var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { vStore in
//
//        }
//    }
//}
//
//// MARK: - SwiftUI previews
//
//#if DEBUG
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(
//            store: Store(
//                initialState: Home.State(),
//                reducer: Home()
//            )
//        )
//    }
//}
//#endif
