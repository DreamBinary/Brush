//
//  ContentView.swift
//  Brush
//
//  Created by cxq on 2023/6/20.
//

import ComposableArchitecture
import SwiftUI
struct MyData: Codable {
    let timestamp: Date
    let message: String
}

struct ContentView: View {
    var body: some View {
        MainView(
            store: Store(
                initialState: Main.State(),
                reducer: Main()
            )
        )
        
        
//        EmptyPageView()
//        Text("\(Date().time())")
//            .onAppear {
//                print(Date().time())
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
