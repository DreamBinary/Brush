//
//  Avatar.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import SwiftUI

struct Avatar: View {
    var radius: CGFloat = 30
    var img: String = "Avatar"
    var fillColor: Color = .black
    var body: some View {
        ZStack {
            Circle()
                .fill(fillColor)
            Image(img)
                .resizable()
                .padding(.all, 5)
        }.frame(width: radius * 2, height: radius * 2)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}
