//
//  Analysis.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI


// MARK: - Feature domain

struct Analysis: ReducerProtocol {
    
    struct State: Equatable {
        
        
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

struct AnalysisView: View {
    let store: StoreOf<Analysis>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView(
            store: Store(
                initialState: Analysis.State(),
                reducer: Analysis()
            )
        )
    }
}
#endif
