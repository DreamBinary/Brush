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
//        TmpExchange()
        LoginView(
            store: Store(
                initialState: Login.State(),
                reducer: Login()
            )
        )
//        RouteView(
//            store: Store(
//                initialState: Route.State(),
//                reducer: Route()
//            )
//        )
//        TmpExchange()
//        BrushView(
//            store: Store(
//                initialState: Brush.State(),
//                reducer: Brush()
//            )
//        )
//        MainView(
//            store: Store(
//                initialState: Main.State(),
//                reducer: Main()
//            )
//        )
//        ZStack(alignment: .center) {
//            SquareIconView(iconImage: vStore.purpleToothVm.image, color: vStore.purpleToothVm.color, sideLength: 200)
//                .rotationEffect(Angle(degrees: vStore.purpleToothVm.angle), anchor: .center)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
