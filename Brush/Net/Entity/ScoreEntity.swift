//
//  ScoreEntity.swift
//  Brush
//
//  Created by cxq on 2023/8/26.
//

import Foundation

struct ScoreEntity: Codable, Equatable, Identifiable {
    var id: Int = 0
    var totalScore: Int = 0
    var timeScore: Int = 0
    var frequencyScore: Int = 0
    var powerScore: Int = 0
    var areaTotalScoreList: [Int] = []
    var areaTimeScoreList: [Int] = []
    var areaFrequencyScoreList: [Int] = []
    var areaPowerScoreList: [Int] = []
}
