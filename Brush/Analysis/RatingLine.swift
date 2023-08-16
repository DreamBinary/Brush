//
//  RatingLine.swift
//  Brush
//
//  Created by cxq on 2023/8/16.
//
import Charts
import SwiftUI

struct Score {
    var date: Date
    var score: Int
}
let score: [Score] = [
    Score(date: Date(), score: 100),
    Score(date: Date().addingTimeInterval(1000), score: 80),
    Score(date: Date().addingTimeInterval(2000), score: 60),
    Score(date: Date().addingTimeInterval(3000), score: 45),
    Score(date: Date().addingTimeInterval(4000), score: 89),
    Score(date: Date().addingTimeInterval(5000), score: 99),
]

struct RatingLine: View {
    var body: some View {
        Chart {
            ForEach(score, id: \.date) { item in
                LineMark(x: .value("Date", item.date), y: .value("Score", item.score))
            }
        }
    }
}



#if DEBUG
struct RatingLine_Previews: PreviewProvider {
    static var previews: some View {
        RatingLine()
    }
}
#endif
