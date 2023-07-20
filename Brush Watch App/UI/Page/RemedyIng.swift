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
        BgColor(.white) {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Image("SignIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Text("把缺失的音律补起来！")
                        .font(.body)
                        .foregroundColor(.fontBlack)
                        .fontWeight(.bold)
                }.padding(.bottom)

//                GeometryReader { geo in
//                    val height = ge
//
//
//                    AnimCheckCircle().padding()
//
//                }
                
                GeometryReader { geo in
                    let height = geo.size.height - 20
                    HStack {
                        Spacer()
                        AnimCheckCircle(
                            size: CGSize(width: height, height: height),
                            finalOuterTrimEnd : 0.7,
                            fromColor: .lightPrimary,
                            toColor: .primary
                        )
                        Spacer()
                    }
                }

                VoiceAnimation(
                    width: 4,
                    height: [
                        7.5, 8.5, 10.5, 6.5, 9.5, 6.5, 12.5, 8.5, 6,
                        6, 7.5, 8.5, 10.5, 6.5, 8.5, 6.5, 12.5, 9.5, 6, 8.5
                    ],
                    color: .primary
                ).frame(height: 10)

                Text(SectionUtil.getName(section))
                    .font(.caption2)
                    .foregroundColor(.fontBlack)
                    .padding()
            }.frame(maxWidth: .infinity)
                .padding(.bottom)
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
