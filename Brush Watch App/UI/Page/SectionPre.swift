//
//  Section.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionPre: View {
    
    var section: Section
    
    var body: some View {
        BgColor(.primary) {
            VStack(spacing: 0) {
                Image("OLB")
                    .resizable()
                    .scaledToFit()
                Spacer()
                Text(SectionUtil.getName(section))
                    .font(.title2)
                    .fontWeight(.bold)
            }.padding(.bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension SectionPre {
    init(_ section: Section) {
        self.section = section
    }
}

struct SectionPre_Previews: PreviewProvider {
    static var previews: some View {
        SectionPre(.OLB)
    }
}
