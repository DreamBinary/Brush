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
    var onTap: () -> Void
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0 ..< 10) { index in
                Rectangle().cornerRadius(width / 2)
                    .frame(width: width, height: height[index])
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true).delay(Double(index) * 0.4), value: height[index])
            }
        }.onTapGesture {
            onTap()
            for i in height.indices {
                height[i] *= 2.5
            }
        }
    }
}

struct VoiceAnimation_Previews: PreviewProvider {
    static var previews: some View {
        VoiceAnimation(){
            
        }
    }
}
