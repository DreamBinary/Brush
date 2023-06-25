//
//  ContentView.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ConnectEar()
            Start()
            SectionStart()
            SectionIng()
            SectionEd()
            Tip()
            Score()
            RemedySelect()
            RemedyIng()
            Finished()
        }.tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
