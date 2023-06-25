//
//  VoiceAnimation.swift
//  Brush
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct VoiceAnimation: View {
    var width: CGFloat = 10
    @State var height: [CGFloat] = [
        15, 36, 72, 52, 36, 23, 52, 70, 52, 20,
        60, 76, 47, 36, 52, 32, 41, 70, 45, 40,
        52, 70, 42, 15, 36
    ]
    @State var current = 0.0
    let timer = MyTimer(interval: 0.001)
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0 ..< 25) { index in
                let delayTime: Double = .init(index + 1) * 0.4
                Rectangle().cornerRadius(width / 2)
                    .foregroundColor(current > delayTime ? Color(0x7DE2D1): Color(0xC4C4C4))
                    .frame(width: width, height: height[index])
                    .animation(Animation.easeInOut(duration: 0.5)
                        .repeatForever(autoreverses: true)
                        .delay(delayTime), value: height[index])
            }
        }.onTapGesture {
            for i in height.indices {
                height[i] *= 1.5
            }
            self.timer.start()
        }.onReceive(self.timer.timer) { _ in
            if self.current < 15 {
                self.current += 0.001
            } else {
                self.timer.stop()
            }
        }
//        .onAppear {
//            var a: [CGFloat] = []
//
//            for _ in 0..<20 {
//                a.append(CGFloat(Float.random(in: 20..<40)))
//            }
//            height = a
//        }
    }
}

struct VoiceAnimation_Previews: PreviewProvider {
    static var previews: some View {
        VoiceAnimation()
    }
}
