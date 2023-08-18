//
//  Popup.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/8/18.
//

import SwiftUI
import PopupView


extension View {
    func toast(
        showToast:Binding<Bool>,
        iconName:String = "circle",
        iconColor:Color = .purple,
        iconSize:CGFloat = 24,
        text:String = "这是一条提示框",
        textColor:Color = .white,
        textSize:CGFloat = 16,
        bgColor:Color = .red,
        duration:Double = 1.0) -> some View {
        ZStack {
            self
            if showToast.wrappedValue{
                Rectangle().frame(width: 0,height: 0)
                .popup(isPresented: showToast) {
                    HStack(spacing: 8) {
                        Image(systemName: iconName)
                            .foregroundColor(iconColor)
                            .frame(width: iconSize, height: iconSize)
                        
                        Text(text)
                            .foregroundColor(textColor)
                            .font(.system(size: textSize))
                    }
                    .padding(16)
                    .background(bgColor.cornerRadius(12))
                    .padding(.horizontal, 16)
                    
                } customize: {
                    $0
                        .type(.floater())
                        .position(.bottomLeading)
                        .appearFrom(.bottom)
                        .animation(.spring())
                }
            }
            
        }
     }
}
