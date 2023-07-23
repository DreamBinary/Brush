//
//  ContentView.swift
//  Brush
//
//  Created by cxq on 2023/6/20.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    // 登录状态字段
    @State private var isLogin = false
    
    var body: some View {
        LoginView(
            store: Store(
                initialState: Login.State(),
                reducer: Login()
            )
        )
//        if !isLogin {
////            Welcome()
//        }
//        else {
//            RouteView(
//                store: Store(
//                    initialState: Route.State(),
//                    reducer: Route()
//                )
//            )
//        }
        
        

//        TabView {
//
//            Welcome()
//            LoginView(
//                store: Store(
//                    initialState: Login.State(),
//                    reducer: Login()
//                )
//            )
//
//            CountDown()
//            Section()
//
//            TabView {
//                TestView(
//                    store: Store(
//                        initialState: Test.State(toothImg: "ToothXraySpot", tip: "在摄入较冰食物的时候，您是否齿感到酸痛难忍"),
//                        reducer: Test()
//                    )
//                )
//                TestView(
//                    store: Store(
//                        initialState: Test.State(toothImg: "ToothGum", tip: "您在刷牙的时候，是否经常出现牙龈出血的情况"),
//                        reducer: Test()
//                    )
//                )
//                TestView(
//                    store: Store(
//                        initialState: Test.State(toothImg: "Cavity", tip: "在使用牙齿的时候，是否经常感到松软无力"),
//                        reducer: Test()
//                    )
//                )
//            }.tabViewStyle(.page(indexDisplayMode: .never))
//                .edgesIgnoringSafeArea(.all)
//
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
