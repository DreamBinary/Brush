//
//  StartBrush.swift
//  Brush
//
//  Created by cxq on 2023/8/1.
//

import SwiftUI

struct StartBrush: View {
    var body: some View {
        BgColor {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                VStack {
                    ZStack(alignment: .center) {
                        Image("Squiggles")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width)
                        Image("ToothShine")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width * 0.6)
                    }
                    
                    Text("开始刷牙!")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 1)
                    Text("让我们一起刷动音律吧!")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.fontGray)
                    Spacer()
                    BrushIcon(
                        radius: 30,
                        color: .white,
                        opacity: 0.57
                    ).onTapGesture {
                        
                    }
                    Image("StartTuneBrush").padding(.bottom, 50).padding(.top, 8)
                }
            }
        }
    }
}

struct StartBrush_Previews: PreviewProvider {
    static var previews: some View {
        StartBrush()
    }
}
