//
//  BrushIcon.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct BrushIcon: View {
    var radius: Double = 30
    var color: Color = .init(0xBEFFD0)
    var opacity: Double = 0.81
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color) // 设置圆的颜色
                .opacity(opacity) // 设置透明度
                .frame(width: radius * 2, height: radius * 2) // 设置圆的大小
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 0) // 添加外部阴影
            Tooth(radius: radius * 0.65)
        }
    }
}

struct Tooth: View {
    var radius: Double
    var body: some View {
        Image("TuneBrushLogo")
            .resizable()
            .scaledToFit()
            .shadow(color: Color(0x000000, 0.25), radius: 10, x: 2, y: 3)
            .frame(width: radius * 2, height: radius * 2)
    }
}

enum BtnType {
    case white
    case purple
    case green
}

class BrushBtnStatus: Equatable {
    static func == (lhs: BrushBtnStatus, rhs: BrushBtnStatus) -> Bool {
        lhs.bgColor == rhs.bgColor && lhs.radius == rhs.radius && lhs.opacity == rhs.opacity
    }

    var bgColor: Color = .white
    var radius: Double = 30
    var opacity: Double = 0.57

    func change(to type: BtnType) {
        switch type {
            case .white:
                toWhite()
            case .purple:
                toPurple()
            case .green:
                toGreen()
        }
    }

    private func toWhite() {
        bgColor = .white
        radius = 30
        opacity = 0.57
    }

    private func toPurple() {
        bgColor = Color(0xADC4FF)
        radius = 40
        opacity = 0.65
    }

    private func toGreen() {
        bgColor = Color(0xBEFFD0)
        radius = 40
        opacity = 0.81
    }
}

struct BrushIcon_Previews: PreviewProvider {
    static var previews: some View {
        BrushIcon()
    }
}
