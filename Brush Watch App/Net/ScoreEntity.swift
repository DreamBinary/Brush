//
//  ScoreEntity.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/26.
//

import Foundation

struct ScoreEntity: Codable {
    var timeScore: Int = 0
    var powerScore: Int = 0
    var powerScoreList: [Int] = []
}
