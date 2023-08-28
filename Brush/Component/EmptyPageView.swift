//
//  EmptyPage.swift
//  Brush
//
//  Created by cxq on 2023/8/28.
//

import SwiftUI
import Lottie
struct EmptyPageView: View {
    var onRefresh: (() -> Void)?
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let lottieSize = min(width, height) / 2
            VStack {
                LottieView(filename: "empty.json")
                    .frame(width: lottieSize, height: lottieSize)
                Group {
                    Text("暂无数据")
                        .font(.body)
                    Text("NOTHING")
                        .font(.callout)
                }.fontWeight(.medium)
                    .foregroundColor(.fontBlack)
                if (onRefresh != nil) {
                    Text("Refresh")
                        .font(.caption)
                        .foregroundColor(.fontGray)
                        .underline()
                        .padding()
                        .onTapGesture {
                            onRefresh!()
                        }
                }
            }.frame(width: width, height: height)
        }
    }
}

struct EmptyPageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPageView(){}
    }
}
