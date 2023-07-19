//
//  BgColor.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/19.
//

import SwiftUI


struct BgColor<Content>: View where Content: View {
    var color: Color
    var content: () -> Content
    
    var body: some View {
        content()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(color)
    }
}

extension BgColor {
    init(_ color: Color, @ViewBuilder _ content: @escaping () -> Content) {
        self.color = color
        self.content = content
    }
}

struct BgColor_Previews: PreviewProvider {
    static var previews: some View {
        BgColor(.black){
            Text("hello")
        }
    }
}
