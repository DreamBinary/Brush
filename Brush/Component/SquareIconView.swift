//
//  SquareIconView.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/7/21.
//

import SwiftUI

struct SquareIconView: View {
    var iconImage: Image
    var color: Color
    var sideLength: CGFloat
    var degrees: Double
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(color)
                .frame(width: sideLength, height: sideLength)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
                .shadow(color: .black.opacity(0.1), radius: 4.5, x: 2, y: -4)
                .shadow(color: .black.opacity(0.09), radius: 8.5, x: 8, y: -15)
                .shadow(color: .black.opacity(0.05), radius: 11.5, x: 17, y: -33)
                .shadow(color: .black.opacity(0.01), radius: 13.5, x: 31, y: -59)
                .shadow(color: .black.opacity(0), radius: 14.5, x: 48, y: -93)
                
            iconImage
                .resizable()
                .scaledToFit()
                .frame(width: sideLength * 0.8, height: sideLength * 0.8)
        }.rotationEffect(.degrees(degrees), anchor: .center)
    }
}

// struct SquareIconView_Previews: PreviewProvider {
//    static var previews: some View {
//        SquareIconView(iconImage: Image("ToothGum"), color: Color(0xA9FDC1), sideLength: 100)
//            .padding()
//    }
// }
//
