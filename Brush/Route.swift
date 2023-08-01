//
//  Route.swift
//  Brush
//
//  Created by cxq on 2023/6/20.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Route: ReducerProtocol {
    struct State: Equatable {
        @BindingState var selection: Int = 0
        var tune = Tune.State()
        var analysis = Analysis.State()
        var mine = Mine.State()
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case tune(Tune.Action)
        case analysis(Analysis.Action)
        case mine(Mine.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.tune, action: /Action.tune) { Tune() }
        Scope(state: \.analysis, action: /Action.analysis) { Analysis() }
        Scope(state: \.mine, action: /Action.mine) { Mine() }

        BindingReducer()
        Reduce { _, action in
            switch action {
                case .binding, .tune, .analysis, .mine:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct RouteView: View {
    let store: StoreOf<Route>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            ZStack(alignment: .bottom) {
                TabView(selection: vStore.binding(\.$selection)) {
                    AnalysisView(
                        store: store.scope(state: \.analysis, action: Route.Action.analysis)
                    ).tag(0)
                    TuneView(
                        store: store.scope(state: \.tune, action: Route.Action.tune)
                    ).tag(1)
            
                    MineView(
                        store: store.scope(state: \.mine, action: Route.Action.mine)
                    ).tag(2)
                }.edgesIgnoringSafeArea(.all)
                    .padding(.bottom, MyTabBar.height + 8)
                HStack {
                    Spacer()
                    MyTabBar(selectedIndex: vStore.binding(\.$selection))
                    Spacer()
                }.background(.white)
            }.onAppear {
                UITabBar.appearance().isHidden = true
            }
        }
    }
}

// extension UITabBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//        guard let window = UIApplication.shared.keyWindow else {
//            return super.sizeThatFits(size)
//        }
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = window.safeAreaInsets.bottom + 65
//        return sizeThatFits
//    }
// }

// MARK: - SwiftUI previews

#if DEBUG
struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView(
            store: Store(
                initialState: Route.State(),
                reducer: Route()
            )
        )
    }
}
#endif
