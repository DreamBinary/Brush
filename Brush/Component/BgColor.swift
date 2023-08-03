//
//  BgView.swift
//  Brush
//  背景视图
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct BgColor<Content>: View where Content: View {
    var content: () -> Content

    var body: some View {
        content()
            .frame(width: screenWidth, height: screenHeight)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.49, green: 0.89, blue: 0.82), location: 0.05),
                        Gradient.Stop(color: Color(red: 0.61, green: 0.92, blue: 0.86), location: 0.47),
                        Gradient.Stop(color: Color(red: 0.09, green: 0.76, blue: 0.65), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.55, y: 0.02),
                    endPoint: UnitPoint(x: 0.98, y: 1)
                )
            )
    }
}

struct BgColor_Previews: PreviewProvider {
    static var previews: some View {
        BgColor {
            Spacer()
        }
    }
}
