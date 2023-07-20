//
//  AnimCheckCircle.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/20.
//

import SwiftUI

struct AnimCheckCircle: View {
    var animationDuration: Double = 0.75
    var shouldScale = true
    var size: CGSize = .init(width: 100, height: 100)
    var innerShapeSizeRatio: CGFloat = 1/3
    var finalOuterTrimEnd: CGFloat = 1
    var fromColor: Color = .blue
    var toColor: Color = .green
    var strokeStyle: StrokeStyle = .init(lineWidth: 8, lineCap: .round, lineJoin: .round)
    var animateOnTap = true
    var outerShape: AnyShape = .init(Circle())
    var onAnimationFinish: (() -> Void)?
    
    
    @State private var outerTrimEnd: CGFloat = 0
    @State private var innerTrimEnd: CGFloat = 0
    @State private var strokeColor = Color.blue
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            
            outerShape
                .trim(from: 0.0, to: 1)
                .stroke(fromColor, style: strokeStyle)
                .rotationEffect(.degrees(-90))
            
            
            outerShape
                .trim(from: 0.0, to: outerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
                .rotationEffect(.degrees(-90))
            
            Checkmark()
                .trim(from: 0, to: innerTrimEnd)
                .stroke(strokeColor, style: strokeStyle)
                .frame(width: size.width * innerShapeSizeRatio,
                       height: size.height * innerShapeSizeRatio)
        }
        .frame(width: size.width, height: size.height)
        .scaleEffect(scale)
        .onAppear() {
            strokeColor = fromColor
            animate()
        }
        .onTapGesture {
            if animateOnTap {
                outerTrimEnd = 0
                innerTrimEnd = 0
                strokeColor = fromColor
                scale = 1
                animate()
            }
        }
    }
    
    
    func animate() {
        if shouldScale {
            withAnimation(.linear(duration: 0.4 * animationDuration)) {
                outerTrimEnd = finalOuterTrimEnd
            }
            
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.4 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.7 * animationDuration)
            ) {
                strokeColor = toColor
                scale = 1.1
            }
            
            withAnimation(
                .linear(duration: 0.1 * animationDuration)
                .delay(0.9 * animationDuration)
            ) {
                scale = 1
            }
        } else {
            withAnimation(.linear(duration: 0.5 * animationDuration)) {
                outerTrimEnd = finalOuterTrimEnd
            }
            withAnimation(
                .linear(duration: 0.3 * animationDuration)
                .delay(0.5 * animationDuration)
            ) {
                innerTrimEnd = 1.0
            }
            
            withAnimation(
                .linear(duration: 0.2 * animationDuration)
                .delay(0.8 * animationDuration)
            ) {
                strokeColor = toColor
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            onAnimationFinish?()
        }
    }
}

struct AnyShape: Shape {
    private var path: (CGRect) -> Path
    
    init<S>(_ shape: S) where S: Shape {
        path = shape.path(in:)
    }
    
    func path(in rect: CGRect) -> Path {
        return path(rect)
    }
}


struct AnimCheckCircle_Previews: PreviewProvider {
    static var previews: some View {
        AnimCheckCircle()
    }
}
