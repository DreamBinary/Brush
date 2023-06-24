//
//  Card.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import SwiftUI

struct Card<Content>: View where Content: View {
    var color: Color = .white
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var corners: UIRectCorner = .allCorners
    var cornerRadius: CGFloat = 15
    var backgroundOpacity: CGFloat = 1
    var content: () -> Content

    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(corners: corners, radius: cornerRadius)
                .background(.clear)
                .foregroundColor(color)
                .opacity(backgroundOpacity)
            content()
        }
        .frame(width: width, height: height)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(color: .red, width: 250, height: 250) {
            Text("hello")
        }
    }
}
