//
//  AggrementView.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/8/18.
//

//
//  LoginWay.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI
import PopupView

struct AggrementView: View {
    @State private var isAgree: Bool = false
    @State private var fontSize: CGFloat = 13
    @State private var showingPopup: Bool = false
    
    @State private var showUserAgreement: Bool = false
    @State private var showPrivacyPolicy: Bool = false


    private var fontColor: Color {
        return isAgree ? Color(0x263238) : Color(0x9f9f9f, 0.59)
    }

    var body: some View {
        HStack (spacing:0){
            Image(systemName: isAgree ? "checkmark.circle" :"circle").foregroundColor(fontColor)
            
            Text("我已阅读并同意").foregroundColor(fontColor).font(Font.system(size: fontSize))
            Text("TuneBrush用户协议").foregroundColor(fontColor).font(Font.system(size: fontSize)).underline(true, color: fontColor)
                .onTapGesture {
                    showUserAgreement=true;
                }
            Text("和").foregroundColor(fontColor).font(Font.system(size: fontSize))
            Text("隐私政策").foregroundColor(fontColor).font(Font.system(size: fontSize)).underline(true, color: fontColor)
                .onTapGesture {
                    showPrivacyPolicy=true;
                }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                isAgree.toggle()
            }
            showingPopup.toggle()
        }
    }
}

struct AggrementView_Previews: PreviewProvider {
    static var previews: some View {
        AggrementView()
    }
}

