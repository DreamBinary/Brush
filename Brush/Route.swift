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
                    NavigationView {
                        VStack {
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            Text("Hello, \(index)!")
                        }
                        .padding()
                        .navigationTitle("Home")
                    }
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
                UITabBar.appearance().backgroundColor = UIColor(red: 191, green: 191, blue: 191, alpha: 0.34)
            }
            //            VStack {
            //                Image(systemName: "globe")
            //                    .imageScale(.large)
            //                    .foregroundColor(.accentColor)
            //                Text("Hello, world!")
            //            }
            //            .padding()
        }
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

