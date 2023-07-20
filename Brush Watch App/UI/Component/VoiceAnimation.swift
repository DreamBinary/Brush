//
//  VoiceAnimation.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct VoiceAnimation: View {
    var width: CGFloat = 2
    @State var height: [CGFloat] = [
        7.5, 8.5, 10.5, 6.5, 8.5, 6.5, 12.5, 8.5, 6, 7.5
    ]
    @State var flag = true
    var color: Color = .white
    var startAnim: () -> Void = {}
    var body: some View {
        HStack(alignment: VerticalAlignment.center, spacing: width / 2) {
            ForEach(0 ..< height.count) { index in
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

struct VoiceAnimation_Previews: PreviewProvider {
    static var previews: some View {
        VoiceAnimation {}
    }
}
