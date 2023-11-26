//
//  TestData.swift
//  Brush
//
//  Created by cxq on 2023/11/26.
//

import Foundation

class TestData {
    static var scoreList = [
        ScoreEntity(id: 0, totalScore: 90, timeScore: 80, frequencyScore: 95, powerScore: 85, areaTotalScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaTimeScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaFrequencyScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaPowerScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70]),
        ScoreEntity(id: 1, totalScore: 90, timeScore: 80, frequencyScore: 95, powerScore: 85, areaTotalScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaTimeScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaFrequencyScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaPowerScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70]),
        ScoreEntity(id: 2, totalScore: 90, timeScore: 80, frequencyScore: 95, powerScore: 85, areaTotalScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaTimeScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaFrequencyScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaPowerScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70]),
        ScoreEntity(id: 3, totalScore: 90, timeScore: 80, frequencyScore: 95, powerScore: 85, areaTotalScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaTimeScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaFrequencyScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaPowerScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70]),
        ScoreEntity(id: 4, totalScore: 90, timeScore: 80, frequencyScore: 95, powerScore: 85, areaTotalScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaTimeScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaFrequencyScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaPowerScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70]),
        ScoreEntity(id: 5, totalScore: 90, timeScore: 80, frequencyScore: 95, powerScore: 85, areaTotalScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaTimeScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaFrequencyScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70], areaPowerScoreList: [80, 75, 91, 88, 70, 75, 85, 78, 75, 91, 88, 70]),
    ]
    
    static var pointList = [
        ScorePoint(id: 1, brushTime: Date(), totalScore: 100),
        ScorePoint(id: 2, brushTime: Date().addingTimeInterval(86400), totalScore: 200),
        ScorePoint(id: 3, brushTime: Date().addingTimeInterval(86400*2), totalScore: 300),
        ScorePoint(id: 4, brushTime: Date().addingTimeInterval(86400*3), totalScore: 400),
        ScorePoint(id: 5, brushTime: Date().addingTimeInterval(86400*4), totalScore: 500),
    ]
}
