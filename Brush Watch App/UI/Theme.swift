//
//  MyExtension.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import Foundation
import SwiftUI

public extension Color {
    static let lightBlack: Color = .init(.sRGB, red: 0.1, green: 0.12, blue: 0.13, opacity: 1)
    static let fontBlack: Color = .init(.sRGB, red: 46 / 255, green: 47 / 255, blue: 81 / 255, opacity: 1)
    static let fontGray: Color = .init(red: 0.51, green: 0.51, blue: 0.51)
    static let primary: Color = .init(red: 0.49, green: 0.89, blue: 0.82)
    static let lightPrimary: Color = .init(red: 0.38, green: 0.86, blue: 0.78, opacity: 0.2)
    
    static let brushBlue: Color = .init(red: 0.56, green: 0.9, blue: 0.94)
}

extension Color {
    init(_ hex: Int, _ alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

public extension UIFont {
    static func textStyleSize(_ style: UIFont.TextStyle) -> CGFloat {
        UIFont.preferredFont(forTextStyle: style).pointSize
    }
}

struct RoundedAndShadowButtonStyle: ButtonStyle {
    var foregroundColor: Color? = .none
    var backgroundColor: Color? = .none
    var cornerRadius: CGFloat = 0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(backgroundColor)
            )
            .compositingGroup()
            .shadow(radius: configuration.isPressed ? 0 : 2, x: 0, y: configuration.isPressed ? 0 : 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(), value: configuration.isPressed)
    }
}
