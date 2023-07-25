//
//  SectionIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionIng: View {
    var section: Section

    @State private var scale: Double = 1

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            VStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.lightPrimary)
                        .frame(width: width * 0.45, height: width * 0.45)
                        .scaleEffect(scale)
                        .animation(Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true), value: scale)
                    Circle()
                        .fill(Color.primary)
                        .frame(width: width * 0.25, height: width * 0.25)

                    VoiceAnimation(minVoiceHeight: width * 0.25 * 0.125) {
                        scale = 5 / 9
                    }
                }.padding()

                HStack {
                    Image("SignIcon")
                    Text(SectionUtil.getName(section))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }.padding()
                Spacer()
                Text("Next：\(SectionUtil.getName(SectionUtil.getNext(section)))")
                    .font(.caption2)
                    .foregroundColor(.fontBlack)
                    .padding()
                
            }.padding(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

extension SectionIng {
    init(_ section: Section) {
        self.section = section
    }
}

struct SectionIng_Previews: PreviewProvider {
    static var previews: some View {
        SectionIng(.OLB)
    }
}
