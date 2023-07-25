//
//  VoiceAnimation.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct VoiceAnimation: View {
    var width: CGFloat = 2
    var minVoiceHeight: CGFloat
    @State private var height: [CGFloat]
    @State private var flag = true
    var color: Color = .white
    var startAnim: () -> Void = {}
    var body: some View {
        HStack(alignment: VerticalAlignment.center, spacing: width / 2) {
            ForEach(0 ..< height.count, id: \.self) { index in
                Rectangle().cornerRadius(width / 2)
                    .foregroundColor(color)
                    .frame(width: width, height: height[index])
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true).delay(Double(index) * 0.4), value: height[index])
            }
        }.onAppear {
            startAnim()
            if flag {
                for i in height.indices {
                    height[i] *= 2.5
                }
                flag = false
            }
        }
    }
}

extension VoiceAnimation {
    init(minVoiceHeight vh: CGFloat = 6,startAnim: @escaping () -> Void = {}) {
        self.minVoiceHeight = vh
        self.startAnim = startAnim
        self.height =  [
           vh + 1.5,
           vh + 2.5,
           vh + 4.5,
           vh + 0.5,
           vh + 2.5,
           vh + 0.5,
           vh + 5.5,
           vh + 2.5,
           vh + 0,
           vh + 1.5
        ]
    }
}

struct VoiceAnimation_Previews: PreviewProvider {
    static var previews: some View {
        VoiceAnimation(minVoiceHeight: 6) {}
    }
}
