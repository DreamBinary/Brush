//
//  InBrush.swift
//  Brush
//
//  Created by cxq on 2023/8/3.
//

import SwiftUI

struct InBrush: View {
    var body: some View {
        BgView("InBrushBg") {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                VStack {
                    Spacer()
                    HStack {
                        BrushIcon(radius: 20, color: .init(0x7DE2D1))
                        Image("TuneBrushGradient")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                        Spacer()
                    }.padding(.leading, 30)
                    
                    VStack(spacing: 0) {
                        Text("尽情享受在 TuneBrush ")
                        GeometryReader { geo2 in
                            let width2 = geo2.size.width
                            HStack {
                                Spacer()
                                Image("DrawLine")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: width2 / 2)
                            }.frame(width: width2)
                        }
                        Text("的交响乐盛典")
                    }.font(.title)
                        .fontWeight(.semibold)
                        .fixedSize()
                    Image("InBrushIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.75)
                        .padding(.trailing)
                        .padding(.vertical, 25)
                    VoiceAnimation()
                    Spacer()
                }.frame(width: width, height: height)
            }
        }.navigationBarBackButtonHidden()
    }
}

struct InBrush_Previews: PreviewProvider {
    static var previews: some View {
        InBrush()
    }
}
