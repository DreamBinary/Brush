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
        TabView {
            RouteView(
                store: Store(
                    initialState: Route.State(),
                    reducer: Route()
                )
            )
            Welcome()
            LoginView(
                store: Store(
                    initialState: Login.State(),
                    reducer: Login()
                )
            )
//            RecordView(
//                store: Store(
//                    initialState: Record.State(),
//                    reducer: Record()
//                )
//            )
//            AnalysisView(
//                store: Store(
//                    initialState: Analysis.State(),
//                    reducer: Analysis()
//                )
//            )
//            MineView(
//                store: Store(
//                    initialState: Mine.State(),
//                    reducer: Mine()
//                )
//            )
            CountDown()
            Section()
            TestView(
                store: Store(
                    initialState: Test.State(),
                    reducer: Test()
                )
            )
            BrushingFinished()
            Generate()
            ResultView(
                store: Store(
                    initialState: Result.State(),
                    reducer: Result()
                )
            )
        }.tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)

//        TabView {
//            MineView(
//                store: Store(
//                    initialState: Mine.State(),
//                    reducer: Mine()
//                )
//            )
//            CountDown()
//            Section()
//            TestView(
//                store: Store(
//                    initialState: Test.State(),
//                    reducer: Test()
//                )
//            )
//            BrushingFinished()
//            Generate()
//            ResultView(
//                store: Store(
//                    initialState: Result.State(),
//                    reducer: Result()
//                )
//            )
//
//        }.tabViewStyle(.page(indexDisplayMode: .never))
//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
