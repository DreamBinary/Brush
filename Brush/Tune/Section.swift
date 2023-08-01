//
//  Section.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct Section: View {
    var body: some View {
        BgView() {
            VStack {
                Image("OutLeftBelow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 180)
                Spacer()
                Text("外左下片区")
                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.5))
                    .fontWeight(.bold)
                    .foregroundColor(Color(0x191D21))
                    .padding(.bottom, 130)
            }
        }
    }
}

struct Section_Previews: PreviewProvider {
    static var previews: some View {
        Section()
    }
}
