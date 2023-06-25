//
//  SectionEd.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct SectionEd: View {
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color(0x61DCC7, 0.2))
                    .frame(width: 90, height: 90)
                
                Circle()
                    .fill(Color(0x7DE2D1))
                    .frame(width: 50, height: 50)
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
            }.padding()
            
            Text("Congratulations!")
                .font(.caption2)
                .foregroundColor(.fontBlack)
            Text("即将进入下一片区")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.49, green: 0.89, blue: 0.82))
                .padding()

            Text("外右下边区")
                .font(.caption)
                .foregroundColor(.fontBlack)
                .padding()

        }.padding(.bottom)
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

struct SectionEd_Previews: PreviewProvider {
    static var previews: some View {
        SectionEd()
    }
}
