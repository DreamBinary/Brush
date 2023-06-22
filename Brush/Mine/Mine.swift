//
//  Mine.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI


// MARK: - Feature domain

struct Mine: ReducerProtocol {
    
    struct State: Equatable {
//        @BindingState var
        var name: String = ""
        
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

struct MineView: View {
    let store: StoreOf<Mine>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView(
            store: Store(
                initialState: Mine.State(),
                reducer: Mine()
            )
        )
    }
}
#endif
