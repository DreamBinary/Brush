//
//  BrushIcon.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct BrushIcon: View {
    var radius: Double = 30
    var color:Color=Color(0xBEFFD0)
    var opacity:Double=0.81
    var imgName:String="TuneBrushLogo"
    
    var body: some View {
        Circle()
            .foregroundColor(color) // 设置圆的颜色
            .opacity(opacity)       // 设置透明度
            .frame(width: radius * 2, height: radius * 2) // 设置圆的大小
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 0) // 添加外部阴影
            .overlay(
                Image(imgName)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(0x000000, 0.25), radius: 10, x: 2, y: 3)
                    .frame(width: radius*1.3, height: radius*1.3)
            )
    }
}

struct BrushIcon_Previews: PreviewProvider {
    static var previews: some View {
        BrushIcon()
    }
}
