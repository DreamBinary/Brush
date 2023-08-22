//
//  AnimatableNumber.swift
//  Brush
//
//  Created by cxq on 2023/8/22.
//

import SwiftUI

struct AnimatableNumberModifier: AnimatableModifier {
    var number: Int
    
    var animatableData: Int {
        get { number }
        set { number = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(number)")
            )
    }
}
