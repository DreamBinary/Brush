//
//  VoiceAnimation.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct VoiceBgAnimation: AnimatableModifier {
    var animatableData: CGFloat {
        get { scale }
        set { scale = newValue }
    }

    @State var scale: CGFloat = 1

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: 2)
                    .repeatForever(autoreverses: true))
                {
                    scale = 2
                }
            }
    }
}

struct VoiceBgAnimation_Previews: PreviewProvider {
    static var previews: some View {
        Circle()
            .frame(width: 50, height: 50)
            .modifier(VoiceBgAnimation())
    }
}
