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

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in

            ZStack {
                TabView(selection: vStore.binding(\.$selection)) {
                    ForEach(0 ..< 5) { index in
                        pages[index]
                            .tag(index)
                    }
                }
                VStack {
                    Spacer()
                    MyTabBar(selectedIndex: vStore.binding(\.$selection))
                }
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
