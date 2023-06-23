//
//  Welcome.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        BgView("Welcome") {
            VStack {
                Spacer()
                Button {
                    print("")
                } label: {
                    Image("bottom20")
                        .shadow(color: Color(0x000000, 0.25), radius: 10, x: 2, y: 3)
                        .padding(.bottom, 80)
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
