//
//  Tip.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI
import WatchKit

struct Tip: View {
    var body: some View {
        Image("Tips")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .onAppear {

            }
    }
}

struct Tip_Previews: PreviewProvider {
    static var previews: some View {
        Tip()
    }
}
