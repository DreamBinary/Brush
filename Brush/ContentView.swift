//
//  ContentView.swift
//  Brush
//
//  Created by cxq on 2023/6/20.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        RouteView(
            store: Store(
                initialState: Route.State(),
                reducer: Route()
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
