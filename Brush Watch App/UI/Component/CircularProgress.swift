//
//  CircularProgress.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

import SwiftUI

struct CircularProgressView<Content>: View where Content: View {
    var score: Int = 0
    let backgroundColor: Color = .init(0x7DE2D1, 0.34)
    let foregroundColor: Color = .init(0x7DE2D1)
    var lineWidth: Double = 10
    var radius: Double = 40

    var content: () -> Content
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .stroke(
                        backgroundColor,
                        lineWidth: lineWidth
                    )
                Circle()
                    .trim(from: 0, to: CGFloat(score) / 100)
                    .stroke(
                        foregroundColor,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.interactiveSpring(), value: CGFloat(score) / 100)
            }
            content().frame(width: radius * 2 - 2 * lineWidth,
                            height: radius * 2 - 2 * lineWidth)
        }.frame(width: radius * 2, height: radius * 2)
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(score: 60) {
            Image(systemName: "checkmark")
        }
    }
}
