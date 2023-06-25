//
//  Section.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionStart: View {
    var body: some View {
        BgView("OutLeftBelow") {
            VStack {
                Spacer()
                Text("外左下片区")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 15)
            }.edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

struct SectionStart_Previews: PreviewProvider {
    static var previews: some View {
        SectionStart()
    }
}
