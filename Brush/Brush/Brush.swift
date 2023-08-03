//
//  Brush.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Brush: ReducerProtocol {
    struct State: Equatable {
//        @BindingState var
    }

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

struct BrushView: View {
    let store: StoreOf<Brush>
    @State var brushState: BrushState = .start
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            switch brushState {
                case .start:
                    StartBrush {
                        withAnimation {
                            brushState = .countdown
                        }
                    }.transition(.move(edge: .top))

                case .countdown:
                    CountDown {
                        withAnimation {
                            brushState = .inn
                        }
                    }.transition(.move(edge: .bottom))

                case .inn:
                    InBrush().transition(.move(edge: .leading))
            }
        }
    }
    
    enum BrushState {
        case start
        case countdown
        case inn
    }
}



// MARK: - SwiftUI previews

#if DEBUG
struct BrushView_Previews: PreviewProvider {
    static var previews: some View {
        BrushView(
            store: Store(
                initialState: Brush.State(),
                reducer: Brush()
            )
        )
    }
}
#endif
