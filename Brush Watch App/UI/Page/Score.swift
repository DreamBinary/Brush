//
//  Score.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct Score: View {
    var score: [String: Int]
    var onBtnTap: () -> Void
    var body: some View {
        BgColor(Color(0xE7EAEA)) {
            VStack {
                Text("本次评分")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height
                    let r = min(width, height)
                    CircleScore(timeScore: score["timeScore"] ?? 0, freqScore: score["freqScore"] ?? 0, powerScore: score["powerScore"] ?? 0)
                        .frame(width: r, height: r)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                Text("OK")
                    .font(.title3)
                    .fontWeight(.medium)
                    .underline(pattern: .solid)
                    .foregroundColor(.fontBlack)
                    .onTapGesture {
                        HapticUtil.click()
                        onBtnTap()
                    }
            }.padding(.bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

