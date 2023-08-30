//
//  ScoreEntity.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/26.
//

import Foundation

struct ScoreEntity: Codable {
    var userId: Int = 0
    var brushTime: String = Date().formattedString()
    var totalScore: Int = 0
    var timeScore: Int = 0
    var frequencyScore: Int = 0
    var powerScore: Int = 0
    var areaTotalScoreList: [Int] = []
    var areaTimeScoreList: [Int] = []
    var areaFrequencyScoreList: [Int] = []
    var areaPowerScoreList: [Int] = []
}

extension Date {
    func formattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
}
