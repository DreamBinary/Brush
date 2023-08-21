//
//  SheetTag.swift
//  Brush
//
//  Created by cxq on 2023/8/21.
//

import SwiftUI

struct SheetTag: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(0xE7EAEA))
            .background(.clear)
            .frame(width: 160, height: 10)
            .cornerRadius(corners: .allCorners, radius: 5)
            .padding(.top)
    }
}

struct SheetTag_Previews: PreviewProvider {
    static var previews: some View {
        SheetTag()
    }
}
