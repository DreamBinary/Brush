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

struct RouteView: View {
    let store: StoreOf<Route>

    let pages = [
        AnyView(RecordView(
            store: Store(
                initialState: Record.State(),
                reducer: Record()
            )
        )),
        AnyView(RecordView(
            store: Store(
                initialState: Record.State(),
                reducer: Record()
            )
        )),
        AnyView(RecordView(
            store: Store(
                initialState: Record.State(),
                reducer: Record()
            )
        )),
        AnyView(AnalysisView(
            store: Store(
                initialState: Analysis.State(),
                reducer: Analysis()
            )
        )),
        AnyView(RecordView(
            store: Store(
                initialState: Record.State(),
                reducer: Record()
            )
        ))
    ]

    let unSeletedImages = [
        "bottom00", "bottom10", "bottom20", "bottom30", "bottom40"
    ]

    let seletedImages = [
        "bottom01", "bottom11", "bottom21", "", "bottom41"
    ]

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            TabView(selection: vStore.binding(\.$selection)) {
                ForEach(0 ..< 5) { index in
                    pages[index]
                        .tabItem {
                            if index == 2 {
                                Image(unSeletedImages[index])
                            } else {
                                Image(vStore.selection == index ? seletedImages[index] : unSeletedImages[index])
                            }
                        }
                        .tag(index)
                }
            }
            .onAppear {
                let standardAppearance = UITabBarAppearance()
                standardAppearance.backgroundColor = UIColor(Color(0xBFBFBF, alpha: 0.1))
                standardAppearance.shadowColor = UIColor(Color(0xBFBFBF))
                //                standardAppearance.backgroundImage = UIImage(named: "custom_bg")
                //                let itemAppearance = UITabBarItemAppearance()
                //                itemAppearance.normal.iconColor = UIColor(Color.white)
                //                itemAppearance.selected.iconColor = UIColor(Color.red)
                //                standardAppearance.inlineLayoutAppearance = itemAppearance
                //                standardAppearance.stackedLayoutAppearance = itemAppearance
                //                standardAppearance.compactInlineLayoutAppearance = itemAppearance
                UITabBar.appearance().standardAppearance = standardAppearance
                UITabBar.appearance().scrollEdgeAppearance = standardAppearance
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 65
        return sizeThatFits
    }
}

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
