//
//  CornerRadius.swift
//  Brush
//
//  Created by cxq on 2023/7/18.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(corners: UIRectCorner, radius: CGFloat) -> some View {
        clipShape(RoundedCorners(corners: corners, radius: radius))
    }
}

struct RoundedCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


