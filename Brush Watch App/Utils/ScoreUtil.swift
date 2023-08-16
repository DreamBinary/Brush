//
//  ScoreUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/8.
//

import Foundation
import SwiftUI

class ScoreUtil {
    private var dataInSecond: [Double] = [] // length 11 --> in a section
    private var scoreInSection: [Double] = [] // length 12
    private var time: Int = 0 // total time is 11 * 12 = 132
    private var cntOneSecond = 11
    var preDataInSecond: [[(Double, Double, Double)]] = .init(repeating: [], count: 15)
    private var curSecond = 0
    func getPreDataInSecond(x: Double, y: Double, z: Double) {
        preDataInSecond[curSecond].append((x, y, z))
        if preDataInSecond[curSecond].count == 20 {
            curSecond += 1
        }
    }

    func sectionProcces() async {
        await secondProccess()
        await computeScoreInSection()

        print("TAG", time)
        print("TAG", scoreInSection)
        dataInSecond.removeAll()
    }

    func getScore() -> [String: Int] {
        var score: [String: Int] = [:]
        //        var powerScore: Int
        //        var timeScore: Int
        //        var sectionScore: Int

        print("TAG", time)
        print("TAG", scoreInSection)

        score["powerScore"] = Int(getAvg(data: scoreInSection))
        score["timeScore"] = Int(time / 132)
        score["sectionScore"] = Int(scoreInSection.min() ?? 0)
        return score
    }

    private func secondProccess() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.computeTime()
            }
            group.addTask {
                await self.computePower()
            }
        }
        preDataInSecond = [[(Double, Double, Double)]](repeating: [], count: 15)
    }

    private func computeTime() async {
        for i in 0 ..< cntOneSecond {
            var cnt = 0
            preDataInSecond[i].forEach { x, y, z in
                if isMotion(x, y, z) {
                    cnt += 1
                }
            }
            if cnt * 2 > preDataInSecond[i].count {
                time += 1
            }
        }
    }

    private func computePower() async {
        let datas = await getDataInSecond()
        await computeDataInSecond(datas: datas)
    }

    // TODO:
    private func isMotion(_ x: Double, _ y: Double, _ z: Double) -> Bool {
        return true
    }

    // TODO:
    private func getDataInSecond() async -> [[Double]] {
        var datas: [[Double]] = []
        for i in 0 ..< cntOneSecond {
            var data: [Double] = []
            preDataInSecond[i].forEach { x, y, z in
                data.append(sqrt(x * x + y * y + z * z))
            }
            datas.append(data)
        }
        return datas
    }

    private func computeDataInSecond(datas: [[Double]]) async {
        for data in datas {
            let length = data.count
            let start = Int(length / 6) //  1 / 6
            let end = start * 5 //  5 / 6
            let datasTmp: [Double] = Array(data.sorted()[start ..< end])
            let avg = getAvg(data: datasTmp)
            dataInSecond.append(avg)
        }
    }

    private func computeScoreInSection() async {
        var datasTmp: [Double] = []
        dataInSecond.forEach { data in
            datasTmp.append(computeScoreInSecond(data: data))
        }
        let avg = getAvg(data: datasTmp)
        scoreInSection.append(avg)
    }

    private func getAvg(data: [Double]) -> Double {
        return data.reduce(0, +) / Double(data.count)
    }

    // TODO:
    private func computeScoreInSecond(data: Double) -> Double {
        return 90
    }
}
