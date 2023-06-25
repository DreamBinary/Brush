//
//  RemedyIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct RemedyIng: View {
    var body: some View {
        BgView("RemedyIng") {
            VStack{
                Spacer()
                Text("外右下边区")
                    .font(.caption2)
                    .foregroundColor(.fontBlack)
                    .padding()
            }.padding(.bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct RemedyIng_Previews: PreviewProvider {
    static var previews: some View {
        RemedyIng()
    }
}
