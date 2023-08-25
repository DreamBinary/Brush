//
//  ContentView.swift
//  Brush
//
//  Created by cxq on 2023/6/20.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView(
            store: Store(
                initialState: Main.State(),
                reducer: Main()
            )
        )
//        TmpExchange()
//        LoginView(
//            store: Store(
//                initialState: Login.State(),
//                reducer: Login()
//            )
//        )
//            RouteView(
//                store: Store(
//                    initialState: Route.State(),
//                    reducer: Route()
//                )
//            )
//

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
