//
//  Score.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct Score: View {
    var onBtnTap: () -> Void
    var body: some View {
        BgColor(.white) {
            VStack {
                Text("本次评分")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        onBtnTap()
                    }
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height
                    let r = min(width, height)
                    CircleScore(powerScore: 89, timeScore: 70, sectionScore: 88).frame(width: r, height: r)
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

struct Score_Previews: PreviewProvider {
    static var previews: some View {
        Score {}
    }
}
