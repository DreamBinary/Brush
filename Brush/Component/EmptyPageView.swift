//
//  EmptyPage.swift
//  Brush
//
//  Created by cxq on 2023/8/28.
//

import SwiftUI
struct EmptyPageView: View {
    var onTap: (() -> Void)?
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height

            VStack {
                Spacer()
                ZStack(alignment: .topLeading) {
                    Image("Empty")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.3)
                        .frame(width: width, height: height)

                    VStack(alignment: .leading, spacing: 2) {
                        Group {
                            Text("暂无数据")
                                .font(.title)
                                .foregroundColor(.fontBlack)
                            Text("本月还未在 TuneBrush 刷牙")
                            Text("现在就开始体验吧")
                        }.fontWeight(.medium)
                            .foregroundColor(.fontGray)
                        if onTap != nil {
                            Image("LetsBegin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width / 3.5)
                                .padding(8)
                                .padding(.horizontal, 8)
                                .background(Color(0x365869))
                                .cornerRadius(corners: .allCorners, radius: 10)
                                .onTapGesture {
                                    onTap!()
                                }
                        }
                    }.padding(.leading)
                        .padding(.top)
                }
            }.frame(width: width, height: height)
        }
    }
}

struct EmptyPageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPageView {}
    }
}
