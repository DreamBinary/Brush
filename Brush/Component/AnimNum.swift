//
//  AnimatableNumber.swift
//  Brush
//
//  Created by cxq on 2023/8/22.
//

import SwiftUI

struct AnimNum<Content> : View where Content: View {
    var num: Int
    @Binding var changeNum: Int
    var content: () -> Content
    var body: some View  {
        content()
            .onAppear {
                animate()
            }.onTapGesture {
                animate()
            }.task(id: num) {
                animate()
            }
    }
    
    func animate() {
        for i: Int in 0 ... num {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) / Double(num)) {
                changeNum = i
            }
        }
    }
}
