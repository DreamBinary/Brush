//
//  ContentView.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Brush()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UserEntity: Codable, Equatable {
    var email: String?
    var username: String?
    var avatar: Int?
    var signature: String?
    var id: Int?
    var registerTime: Date?
}
