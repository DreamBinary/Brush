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
    var cornerRadius: CGFloat = 25

    var content: () -> Content

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(color)
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
