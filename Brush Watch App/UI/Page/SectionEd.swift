//
//  SectionEd.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionEd: View {
    var section: Section
    @State private var animRunning = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.lightPrimary)
                    .frame(width: 90, height: 90)
                Circle()
                    .fill(Color.primary)
                    .frame(width: 50, height: 50)
//                Image(systemName: "checkmark")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 25, height: 25)
                AnimCheck(fromColor: .fontBlack, toColor: .white)

//                Image(systemName: "square.stack.3d.up")
//                    .symbolEffect(.variableColor.reversing.iterative, options: .speed(3), value: animRunning)

            }.padding()

            Text("Congratulations!")
                .font(.caption2)
                .foregroundColor(.fontBlack)
            Text("即将进入下一片区")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()

            Text(SectionUtil.getName(section))
                .font(.caption)
                .foregroundColor(.fontBlack)
                .padding()

        }.padding(.bottom)
            .edgesIgnoringSafeArea(.bottom)
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
