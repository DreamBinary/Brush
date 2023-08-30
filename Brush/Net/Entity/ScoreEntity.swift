//
//  ScoreEntity.swift
//  Brush
//
//  Created by cxq on 2023/8/26.
//
// {
//    "code": 200,
//    "message": "获取记录成功",
//    "data": [
//        {
//            "id": 10000,
//            "brushTime": "2023-08-26T02:22:32.000+00:00",
//            "timeScore": 78,
//            "powerScore": 87,
//            "powerScoreList": [
//                78,
//                78,
//                78,
//                78,
//                78,
//                78,
//                78,
//                78,
//                78,
//                78,
//                78,
//                78
//            ]
//        }
//    ]
// }

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
