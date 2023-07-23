//
//  AnimViolin.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/23.
//

import SwiftUI

struct AnimViolin: View {
    @State var dx: Double = 0
    @State var angle: Double = 0

    @State var attempts: Int = 0

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ZStack(alignment: .center) {
                Image("Violin")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(width: width * 0.70)
                    .rotationEffect(.degrees(angle))
//                    .modifier(Shake(animatableData: CGFloat(attempts)))

                Image("Bow")
                    .resizable()  
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(height: height * 0.60)
                    .padding(.trailing, width * 0.3)
                    .padding(.top, height * 0.05)
                    .offset(x: dx, y: -dx * tan(75.0 / 180.0 * Double.pi))

//                    .onTapGesture {
//
//                    }

            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        dx = 5
                    }
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        angle = 2
                    }
                }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(translationX:
                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0))
    }
}

struct AnimViolin_Previews: PreviewProvider {
    static var previews: some View {
        AnimViolin().background(.white)
    }
}
