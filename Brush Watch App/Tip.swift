//
//  Tip.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct Tip: View {
    var body: some View {
        Image("Tips")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
        
    }
}

struct Tip_Previews: PreviewProvider {
    static var previews: some View {
        Tip()
    }
}
