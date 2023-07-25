//
//  BrushingFinished.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct BrushingFinished: View {
    var body: some View {
//        BgView("BrushingFinished") {
            VStack(spacing: 2) {
                Text("恭喜您！")
                Text("您的牙齿很健康")
                Text("记得好好保持哦")
                    .font(.title3)
                    .foregroundColor(.fontGray)
                    .fontWeight(.regular)
                
                BrushIcon()
                    .padding(.top, 120)
                    
            }.font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 300)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("BrushingFinished"))
                .edgesIgnoringSafeArea(.all)
        
    }
}

struct BrushingFinished_Previews: PreviewProvider {
    static var previews: some View {
        BrushingFinished()
    }
}
