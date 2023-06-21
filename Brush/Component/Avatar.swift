//
//  Avatar.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import SwiftUI

struct Avatar: View {
    var width: CGFloat = 60
    var height: CGFloat = 60
    var img: String = "avatar"
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(0xADB4F2))
            Image(img)
                .resizable()
        }.frame(width: width, height: height)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}
