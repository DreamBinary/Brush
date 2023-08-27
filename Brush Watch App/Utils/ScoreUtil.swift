//
//  ScoreUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/8.
//

import Foundation
import SwiftUI

class ScoreUtil {
    private var dataInSecond: [Double] = [] // length 11 --> in a sectiong
    private var scoreInSection: [Int] = [] // length 12
    private var time: Int = 0 // total time is 11 * 12 = 132
    private var cntOneSecond = 11
    var preDataInSecond: [[(Double, Double, Double)]] = .init(repeating: [], count: 15)
    private var curSecond = 0
    
    private var normalSpeed: Double = 0.33259184633785926
    
    func getPreDataInSecond(x: Double, y: Double, z: Double) {
        print("TAG", x, y, z)
        preDataInSecond[curSecond].append((x, y, z))
        if preDataInSecond[curSecond].count == 60 {
            print("TAG", "--------------" , curSecond)
            curSecond += 1
        }
    }
    
    func sectionProcces() async {
        await secondProccess()
        await computeScoreInSection()
        
        print("TAG", "time", time)
        print("TAG", "dataInSecond", dataInSecond)
        print("TAG", "scoreInSection", scoreInSection)
        dataInSecond.removeAll()
    }
    
    func getScore() -> [String: Int] {
        var score: [String: Int] = [:]
        //        var powerScore: Int
        //        var timeScore: Int
        //        var sectionScore: Int
        print("TAG", "time", time)
        print("TAG", "dataInSecond", dataInSecond)
        print("TAG", "scoreInSection", scoreInSection)
        
        score["powerScore"] = getAvg(data: scoreInSection)
        score["timeScore"] = Int(time / 132)
        score["sectionScore"] = scoreInSection.min() ?? 0
        return score
    }
    
    func getSaveScore() -> ScoreEntity {
        return ScoreEntity(
            timeScore: Int(time / 132),
            powerScore: getAvg(data: scoreInSection),
            powerScoreList: scoreInSection
        )
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
        curSecond = 0
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
        await getDataInSecond()
        //        let datas = await getDataInSecond()
        //        await computeDataInSecond(datas: datas)
    }
    
    // TODO:
    private func isMotion(_ x: Double, _ y: Double, _ z: Double) -> Bool {
        if (abs(x) > 0.01  && abs(y) > 0.05 && abs(z) > 0.01) {
            return true
        }
        return false
    }
    
    // TODO:
    private func getDataInSecond() async {
        var vx: [Double] = []
        var vy: [Double] = []
        var vz: [Double] = []
        for i in 0 ..< cntOneSecond {
            var tx = 0.0
            var ty = 0.0
            var tz = 0.0
            // TODO
            let length = Double(preDataInSecond[i].count)
            preDataInSecond[i].forEach { x, y, z in
                tx += x / length
                ty += y / length
                tz += z / length
            }
            if (i == 0) {
                vx.append(tx)
                vy.append(tx)
                vz.append(tx)
            } else {
                vx.append(vx[i - 1] + tx)
                vy.append(vy[i - 1] + ty)
                vz.append(vz[i - 1] + tz)
            }
            //            vx[i] = i > 0 ? vx[i - 1] + tx : tx
            //            vy[i] = i > 0 ? vy[i - 1] + ty : ty
            //            vz[i] = i > 0 ? vz[i - 1] + tz : tz
            dataInSecond.append(sqrt(vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]))
        }
    }
    
    
    //    private func getDataInSecond() async -> [[Double]] {
    //        var datas: [[Double]] = []
    //        var vx: [Double] = []
    //        var vy: [Double] = []
    //        var vz: [Double] = []
    //        for i in 0 ..< cntOneSecond {
    //            var data: [Double] = []
    //            var tx = 0.0
    //            var ty = 0.0
    //            var tz = 0.0
    //            // TODO
    //            preDataInSecond[i].forEach { x, y, z in
    //                let length = Double(preDataInSecond[i].count)
    //                tx += x / length     // 60 HZ
    //                ty += y / length
    //                tz += z / length
    //            }
    //            vx[i] = i > 0 ? vx[i - 1] + tx : tx
    //            vy[i] = i > 0 ? vy[i - 1] + ty : ty
    //            vz[i] = i > 0 ? vz[i - 1] + tz : tz
    //            datas.append(sqrt(vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]))
    //        }
    //        return datas
    //    }
    //
    //    private func computeDataInSecond(datas: [[Double]]) async {
    //        for data in datas {
    //            let length = data.count
    //            let start = Int(length / 6) //  1 / 6
    //            let end = start * 5 //  5 / 6
    //            let datasTmp: [Double] = Array(data.sorted()[start ..< end])
    //            let avg = getAvg(data: datasTmp)
    //            dataInSecond.append(avg)
    //        }
    //    }
    
    private func computeScoreInSection() async {
        var datasTmp: [Double] = []
        dataInSecond.forEach { data in
            datasTmp.append(computeScoreInSecond(data: data))
        }
        let avg = getAvg(data: datasTmp)
        scoreInSection.append(Int(abs(avg)))
    }
    
    private func getAvg(data: [Double]) -> Double {
        return data.reduce(0, +) / Double(data.count)
    }
    
    private func getAvg(data: [Int]) -> Int {
        return Int(Double(data.reduce(0, +)) / Double(data.count))
    }
    
    // TODO:
    private func computeScoreInSecond(data: Double) -> Double {
        let tmp = 100.0 / normalSpeed * data
        if data <= normalSpeed {
            return tmp
        } else {
            return 200.0 - tmp
        }
    }
}
