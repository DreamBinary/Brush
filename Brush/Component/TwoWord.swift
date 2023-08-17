//
//  Two.swift
//  Brush
//
//  Created by cxq on 2023/8/17.
//

import Foundation
import SwiftUI

struct TwoWord: View {
    var first: String
    var second: String
    var firstFont: Font?
    var secondFont: Font?
    var firstColor: Color?
    var secondColor: Color?
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(first)
                .font(firstFont ?? .largeTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(firstColor ?? .fontBlack)
            Text(second)
                .font(secondFont ?? .callout)
                .foregroundColor(secondColor ?? .fontBlack)
        }
    }
}

extension TwoWord {
    init(_ first: String, _ second: String) {
        self.first = first
        self.second = second
    }
}
