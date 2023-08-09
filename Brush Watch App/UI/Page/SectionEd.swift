//
//  SectionEd.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionEd: View {
    var section: Section
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            VStack {
                Spacer()
                AnimCheckCircle(
                    size: CGSize(width: width * 0.35, height: width * 0.35),
                    fromColor: .lightPrimary, toColor: .primary,
                    strokeStyle: .init(lineWidth: width * 0.35 * 0.08, lineCap: .round, lineJoin: .round))
                Spacer()
                Text("Congratulations!")
                    .font(.caption2)
                    .foregroundColor(.fontBlack)
                Text("即将进入下一片区")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()

                Text(SectionUtil.getName(SectionUtil.getNext(section)))
                    .font(.caption)
                    .foregroundColor(.fontBlack)
                    .padding()

            }.padding(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

extension SectionEd {
    init(_ section: Section) {
        self.section = section
    }
}

struct SectionEd_Previews: PreviewProvider {
    static var previews: some View {
        SectionEd(.OLB)
    }
}
