//
//  Welcome.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

//文字展示组件
struct TextDisplayView: View {
    var text: String
    var fontSize: CGFloat
    var textColor: Color

    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .heavy))
            .italic()
            .foregroundColor(textColor)
            .frame(width: 384, alignment: .bottomLeading)
    }
}


struct Welcome: View {
    var body: some View {
        BgView("welcome") {
            VStack{
                Spacer()
                HStack {
                    SquareIconView(iconImage: Image("ToothGum"), color: Color(hex:"#A9FDC1"), sideLength: 140).rotationEffect(Angle(degrees: 30)).offset(x:-20)
                    Spacer()
                    SquareIconView(iconImage: Image("ToothShine"), color: Color(hex:"#A9C1FD"), sideLength: 200).rotationEffect(Angle(degrees: -20)).offset(x:20)
                }
                Spacer()
                VStack(spacing: 0){
                    TextDisplayView(text: "Let's", fontSize: 80, textColor: Color(hex:"#ffffff"))
                    Image("BrushText").frame(width: UIScreen.main.bounds.width, alignment: .bottomLeading)
                    TextDisplayView(text: "With", fontSize: 80, textColor: Color(hex:"#ffffff"))
                    Image("MusicText").frame(width: UIScreen.main.bounds.width, alignment: .bottomLeading)
                    
                }.padding(.leading, 20)
                Spacer()
                VStack(spacing:0){
                    Button {
                        print("")
                    } label: {
                        BrushIcon()
                            .padding(.bottom, 65)
                    }
                    
                    Text("ttt")
                }

            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
