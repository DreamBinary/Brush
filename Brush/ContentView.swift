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
        BrushView(
            store: Store(
                initialState: Brush.State(),
                reducer: Brush()
            )
        )
//        MainView(
//            store: Store(
//                initialState: Main.State(),
//                reducer: Main()
//            )
//        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
