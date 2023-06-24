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
                    BrushIcon()
                        .padding(.bottom, 65)
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
