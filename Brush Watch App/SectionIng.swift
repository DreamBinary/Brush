//
//  SectionIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionIng: View {
    var body: some View {
        VStack {
            Spacer()
            Image("Brushing")

            HStack {
                Image("ResultIcon")

                Text("外左下片区")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.49, green: 0.89, blue: 0.82))
            }.padding()
            Spacer()
            Text("Next：外右下边区")
                .font(.caption)
                .foregroundColor(.fontBlack)
                .padding()

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
