//
//  RemedySelect.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct RemedySelect: View {
    var body: some View {
        BgView("RemedySelect") {
            VStack {
                Spacer()

                Button {} label: {
                    Text("开始弥补")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(Color(0xEFF1FF, 0.59))
                        .cornerRadius(5)
                }.buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderless)
                Button {} label: {
                    Text("就这样吧")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .underline(pattern: .solid)
                        .foregroundColor(.fontBlack)
                }.buttonStyle(.plain)
                    .padding(.bottom)
            }.padding(.bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct RemedySelect_Previews: PreviewProvider {
    static var previews: some View {
        RemedySelect()
    }
}
