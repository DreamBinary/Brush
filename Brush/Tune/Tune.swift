//
//  Tune.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI


// MARK: - Feature domain

struct Tune: ReducerProtocol {
    
    struct State: Equatable {
//        @BindingState var
        
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                    
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct TuneView: View {
    let store: StoreOf<Tune>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            VStack {
                Text("Hello")
            }
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct TuneView_Previews: PreviewProvider {
    static var previews: some View {
        TuneView(
            store: Store(
                initialState: Tune.State(),
                reducer: Tune()
            )
        )
    }
}
#endif
