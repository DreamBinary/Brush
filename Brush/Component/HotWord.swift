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
    init(_ content: String, paddingH: CGFloat = 20, paddingV: CGFloat = 15) {
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
            
    }
    
//    func backgroundColor(_ color: Color) -> some View {
//        return self.body.background(color)
//            .cornerRadius(10)
//            .shadow(color: Color(0x000000, 0.25), radius: 5, x: 2, y: 4)
//    }
}
