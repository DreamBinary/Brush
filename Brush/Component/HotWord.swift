//
//  HotWord.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct HotWord: View {
    var content: String
    var paddingH: CGFloat
    var paddingV: CGFloat
    
    @State private var shadowRadius: Double = 0
    @State private var shadowX: Double = 0
    @State private var shadowY: Double = 0
    init(_ content: String, paddingH: CGFloat = 18, paddingV: CGFloat = 15) {
        self.content = content
        self.paddingV = paddingV
        self.paddingH = paddingH
    }
    
    var body: some View {
        Text(self.content)
            .padding(.horizontal, self.paddingH)
            .padding(.vertical, self.paddingV)
            .fontWeight(.semibold)
            .background(Color(0xF2F7F5))
            .cornerRadius(10)
            .shadow(color: Color(0x000000, 0.25), radius: shadowRadius, x: shadowX, y: shadowY)
            .onAppear {
                animate()
            }
            .onTapGesture {
                animate()
            }
            
    }
    
    func animate() {
        shadowRadius = 0
        shadowX = 0
        shadowY = 0
        withAnimation {
            shadowRadius = 5
            shadowX = 2
            shadowY = 4
        }
    }
    
//    func backgroundColor(_ color: Color) -> some View {
//        return self.body.background(color)
//            .cornerRadius(10)
//            .shadow(color: Color(0x000000, 0.25), radius: 5, x: 2, y: 4)
//    }
}
