//
//  RemedyIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct RemedyIng: View {
    var section: Section
    var body: some View {
        BgColor(.red) {
            WeightVStack { proxy in 
                Image("SignIcon")
                    .resizable()
                    .scaledToFit()
                Text("把缺失的音律补起来！")
                    .font(.body)
                    .foregroundColor(.fontBlack)
                    .fontWeight(.bold)
                CircularProgressView(score: 60) {
                    Image(systemName: "checkmark")
                }.padding()
                Spacer()
                Text(SectionUtil.getName(section))
                    .font(.caption2)
                    .foregroundColor(.fontBlack)
                    .padding()
            }.padding(.bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension RemedyIng {
    init(_ section: Section) {
        self.section = section
    }
}

struct RemedyIng_Previews: PreviewProvider {
    static var previews: some View {
        RemedyIng(.OLB)
    }
}
