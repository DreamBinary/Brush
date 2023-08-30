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
        .onAppear {
            Task {
                //                    let user = User()
                let response: Response<User?> = try await ApiClient.request("https://tunebrush-api.shawnxixi.icu/api/users/login", method: .POST, params: ["email": "tunebrush@shawnxixi.icu","plainPassword": "qqqqqq"])
                print("TAG", response.code ?? 0)
                print("TAG", response.data)
                //                    let score = ScoreEntity()
                //                    let data = try JSONEncoder().encode(score)
                //                            let dataString = String(data: data, encoding: .utf8)
                //                            print(dataString)
            }
        }
        
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
