//
//  CircularProgress.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

import SwiftUI

struct CircularProgressView: View {
    var score: Int = 0
    var backgroundColor: Color = .init(0x7DE2D1, 0.34)
    var foregroundColors: [Color] = [.red, .blue]
    var lineWidth: Double = 10
    var radius: Double = 40
    @State private var value: Double = 0

    var body: some View {
        let selectPoints: [UnitPoint] = RandomUtil.rSelect(data: [.topLeading, .top, .topTrailing, .trailing, .bottomTrailing, .bottom, .bottomLeading, .leading], num: 2)
        ZStack {
            Circle()
                .stroke(
                    backgroundColor,
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: value)
                .stroke(
                    LinearGradient(colors: foregroundColors, startPoint: selectPoints[0], endPoint: selectPoints[1]),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }.frame(width: radius * 2, height: radius * 2)
            .onAppear {
                animate()
            }
            .onTapGesture {
                value = 0
                animate()
            }
    }

    func animate() {
        withAnimation(.interactiveSpring(response: 1)) {
            value = Double(score) / 100
        }
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(score: 60)
    }
}
