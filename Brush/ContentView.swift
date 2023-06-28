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

            TabView {
                TestView(
                    store: Store(
                        initialState: Test.State(toothImg: "ToothXraySpot", tip: "在摄入较冰食物的时候，您是否牙齿感到酸痛难忍"),
                        reducer: Test()
                    )
                )
                TestView(
                    store: Store(
                        initialState: Test.State(toothImg: "ToothGum", tip: "您在刷牙的时候，是否经常出现牙龈出血的情况"),
                        reducer: Test()
                    )
                )
                TestView(
                    store: Store(
                        initialState: Test.State(toothImg: "Cavity", tip: "在使用牙齿的时候，是否经常感到松软无力"),
                        reducer: Test()
                    )
                )
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)

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
