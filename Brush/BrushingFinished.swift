//
//  BrushingFinished.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct BrushingFinished: View {
    var body: some View {
        BgView("BrushingFinished") {
            VStack(spacing: 2) {
                Text("恭喜您！")
                Text("您的牙齿很健康")
                Text("记得好好保持哦")
                    .font(.title3)
                    .foregroundColor(.fontGray)
                    .fontWeight(.regular)
                
                
                Image("bottom20")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .shadow(color: Color(0x000000,  0.25), radius: 10, x: 2, y: 3)
                    .padding(.top, 120)
                    
                    
                
            }.font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 300)
                
        }
    }
}

struct BrushingFinished_Previews: PreviewProvider {
    static var previews: some View {
        BrushingFinished()
    }
}
