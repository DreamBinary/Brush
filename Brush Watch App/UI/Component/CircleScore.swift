//
//  CircleScore.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/3.
//

import SwiftUI

struct CircleScore: View {
    var firstScore: Int = 0
    var secondScore: Int = 0
    var thirdScore: Int = 0
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let lineWidth = width * 0.07
            ZStack(alignment: .center) {
                CircularProgressView(score: firstScore, backgroundColor: Color(0xEBF7F1), foregroundColors: [Color(0x8FF1DF), Color(0x64E9C1)], lineWidth: lineWidth, radius: width * 0.35)
                CircularProgressView(score: secondScore, backgroundColor: Color(0xE0F3F3), foregroundColors: [Color(0xB1E8FF), Color(0x62DAF5)], lineWidth: lineWidth, radius: width * 0.25)
                CircularProgressView(score: thirdScore, backgroundColor: Color(0xD0C7F4, 0.5), foregroundColors: [Color(0xA0AEFA), Color(0x2F78E7), Color(0x56B8FF)], lineWidth: lineWidth, radius: width * 0.15)
            }.frame(width: width, height: geo.size.height)
        }
    }
}

extension CircleScore {
    init(timeScore firstScore: Int, freqScore secondScore: Int, powerScore thirdScore: Int) {
        self.firstScore = firstScore
        self.secondScore = secondScore
        self.thirdScore = thirdScore
    }
}

struct CircleScore_Previews: PreviewProvider {
    static var previews: some View {
        CircleScore()
    }
}
