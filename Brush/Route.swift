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
        var brush = Brush.State()
        var analysis = Analysis.State()
        var mine = Mine.State()
        var isSheetPresented = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case brush(Brush.Action)
        case analysis(Analysis.Action)
        case mine(Mine.Action)
        case setSheet(isPresented: Bool)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.brush, action: /Action.brush) { Brush() }
        Scope(state: \.analysis, action: /Action.analysis) { Analysis() }
        Scope(state: \.mine, action: /Action.mine) { Mine() }

        BindingReducer()
        Reduce { state, action in
            switch action {
                case let .setSheet(isPresented):
                    state.isSheetPresented = isPresented
                    return .none
                case .analysis(.onTapGetStarted):
                    state.isSheetPresented = true
                    return .none
                case .brush(.innEnd):
                    state.isSheetPresented = false
                    return .none
                case .binding, .brush, .analysis, .mine:
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
            NavigationView {
                ZStack(alignment: .bottom) {
                    TabView(selection: vStore.binding(\.$selection)) {
                        AnalysisView(
                            store: store.scope(state: \.analysis, action: Route.Action.analysis)
                        ).tag(0)
                        MineView(
                            store: store.scope(state: \.mine, action: Route.Action.mine)
                        ).tag(2)
                    }.edgesIgnoringSafeArea(.all)
                        .padding(.bottom, MyTabBar.height + 8)
                    HStack {
                        Spacer()
                        MyTabBar(selectedIndex: vStore.binding(\.$selection)){
                            vStore.send(.setSheet(isPresented: true))
                        }
                        Spacer()
                    }.background(Color.bgWhite)
                }.background(Color.bgWhite).onAppear {
                    UITabBar.appearance().isHidden = true
                }.sheet(    
                    isPresented: vStore.binding(
                        get: \.isSheetPresented,
                        send: Route.Action.setSheet(isPresented:)
                    )
                ) {
                    BrushView(
                        store: store.scope(state: \.brush, action: Route.Action.brush)
                    ).presentationDetents([.large]).presentationDragIndicator(.visible)
                }
//                .onAppear {
//                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
//                    AppDelegate.orientationLock = .portrait // And making sure it stays that way
//                }.onDisappear {
//                    AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
//                }
            }.navigationViewStyle(.stack)
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
