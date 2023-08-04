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
    enum BrushState {
        case start
        case countdown
        case inn
    }

    struct State: Equatable {
        var brushState: BrushState = .start
    }

    enum Action: BindableAction, Equatable {
        case startEnd
        case countdownEnd
        case innEnd
        case binding(BindingAction<State>)
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .startEnd:
                    withAnimation {
                        state.brushState = .countdown
                    }
                    return .none
                case .countdownEnd:
                    withAnimation {
                        state.brushState = .inn
                    }
                    return .none
                case .innEnd:
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct BrushView: View {
    let store: StoreOf<Brush>
    let util: WatchUtil
    @State private var isPresented: Bool = false
    @State private var msg: String = ""
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            switch vStore.brushState {
                case .start:
                    StartBrush {
                        onStart {
                            vStore.send(.startEnd)
                        }
                    }.transition(.move(edge: .top))
                        .alert(msg, isPresented: $isPresented) {
                            Button("OK") {
                                isPresented = false
                            }
                        }
                case .countdown:
                    CountDown {
                        vStore.send(.countdownEnd)
                    }.transition(.move(edge: .bottom))
                case .inn:
                    InBrush().transition(.move(edge: .leading))
            }
        }
    }

    private func onStart(onFinal: () -> Void) {
        if !util.isPaired() {
            msg = "watch not paired"
            isPresented = true
            return
        }
        if !util.isWatchAppInstalled() {
            msg = "watch app not installed"
            isPresented = true
            return
        }

        if !util.isReachable() {
            msg = "watch not reachable"
            isPresented = true
            return
        }
        util.send2Watch(["start": true])
        onFinal()
    }
}

// MARK: - SwiftUI previews

//#if DEBUG
//struct BrushView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrushView(
//            store: Store(
//                initialState: Brush.State(),
//                reducer: Brush()
//            ),
//            util:
//        )
//    }
//}
//#endif
