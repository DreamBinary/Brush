//
//  SectionIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionIng: View {
    @State var scale: Double = 1
    @State var isPresented = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color(0x61DCC7, 0.2))
                    .frame(width: 90, height: 90)
                    .scaleEffect(scale)
                    .animation(Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true), value: scale)
                Circle()
                    .fill(Color(0x7DE2D1))
                    .frame(width: 50, height: 50)
                VoiceAnimation() {
                    scale = 50 / 90
                }
            }.padding()
//            Image("Brushing")
            
            HStack {
                Image("ResultIcon")

                Text("外左下片区")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.49, green: 0.89, blue: 0.82))
            }.padding()
            Spacer()
            Text("Next：外右下边区")
                .font(.caption2)
                .foregroundColor(.fontBlack)
                .padding()
                .onTapGesture {
                    isPresented = true
                }

        }.padding(.bottom)
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

struct SectionIng_Previews: PreviewProvider {
    static var previews: some View {
        SectionIng()
    }
}
