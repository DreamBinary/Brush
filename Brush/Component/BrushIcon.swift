//
//  BrushIcon.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct BrushIcon: View {
    var radius: Double = 60
    var body: some View {
        Image("BrushIcon")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(0x000000, 0.25), radius: 10, x: 2, y: 3)
            .frame(width: radius, height: radius)
    }
}

struct BrushIcon_Previews: PreviewProvider {
    static var previews: some View {
        BrushIcon()
    }
}
