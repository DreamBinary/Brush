//
//  ScoreUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/8.
//

import Foundation
import SwiftUI

class ScoreUtil {
    private var dataOneSection: [Double] = [] // length 11 --> in a sectiong
    private var powerInSection: [Int] = [] // length 12
    //    private var time: Int = 0 // total time is 11 * 12 = 132
    private var timeInSection: [Int] = []
    private var varInSection: [Int] = []
    
    private var totalTimeInSection = 11
    private var preDataInSecond: [[(Double, Double, Double)]] = .init(repeating: [], count: 15)
    private var curSecond = 0
    private var score: ScoreEntity?
    private var normalSpeed: Double = 0.33259184633785926
    
    func getPreDataInSecond(x: Double, y: Double, z: Double) {
        print("TAG", x, y, z)
        preDataInSecond[curSecond].append((x, y, z))
    }
    
    func addSecond() async {
//        print("TAG", "dataLength", preDataInSecond[curSecond].count)
        curSecond += 1
    }
    
    func sectionProcces() async {
//        print("TAG", "section-------------------------------------------------------")
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.computeTime()
            }
            group.addTask {
                await self.computeData()
            }
        }
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.computeVar()
            }
            group.addTask {
                await self.computePower()
            }
            
        }
        preDataInSecond = [[(Double, Double, Double)]](repeating: [], count: 15)
        curSecond = 0
        dataOneSection.removeAll()
    }
    
    // TODO
    func getScore() -> [String: Int] {
        var result: [String: Int] = [:]
        //        var powerScore: Int
        //        var timeScore: Int
        //        var sectionScore: Int
        print("TAG", "time", time)
        print("TAG", "dataInSecond", dataOneSection)
        print("TAG", "scoreInSection", powerInSection)
        
        result["powerScore"] = score?.powerScore
        result["timeScore"] = score?.timeScore
        result["sectionScore"] = powerInSection.min() ?? 0
        return result
    }
    
    // TODO
    func getSaveScore() -> ScoreEntity {
        score = ScoreEntity(
            timeScore: getTimeScore(),
            powerScore: getAvg(data: powerInSection),
            powerScoreList: powerInSection
        )
        return score!
    }
    
    private func getTimeScore() -> Int {
        let n: Double = 12.0
        let x: Double = 132
        var sum: Double = 0
        for t in timeInSection {
            sum += abs(Double(t) / x - 1 / n)
        }
        
        let result: Double = 1 - n * sum / (2 * n - 2)
        return Int(100 * result)
    }
    
    private func computeTime() async {
        var time: Int = 0
        for i in 0 ..< totalTimeInSection {
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
        timeInSection.append(time)
    }
    
    private func computeData() async {
        var vx: [Double] = []
        var vy: [Double] = []
        var vz: [Double] = []
        for i in 0 ..< totalTimeInSection {
            var tx = 0.0
            var ty = 0.0
            var tz = 0.0
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
//            print("TAG", "XYZ", vx[i], vy[i], vz[i])
            dataOneSection.append(sqrt(vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]))
        }
        //        let datas = await getDataInSecond()
        //        await computeDataInSecond(datas: datas)
    }
    
    private func computePower() async {
        var datasTmp: [Double] = []
        dataOneSection.forEach { data in
            datasTmp.append(computeScoreOneSecond(data: data))
        }
        let avg = getAvg(data: datasTmp)
        powerInSection.append(Int(abs(avg)))
    }
    
    // TODO:
    private func computeScoreOneSecond(data: Double) -> Double {
        let tmp = 100.0 / normalSpeed * data
        if data <= normalSpeed {
            return tmp
        } else {
            return 200.0 - tmp
        }
    }
    
    private func computeVar() async {
        let mean = dataOneSection.reduce(0, +) / Double(dataOneSection.count)
        let squaredDifferences = dataOneSection.map { pow($0 - mean, 2) }
        let variance = squaredDifferences.reduce(0, +) / Double(dataOneSection.count)
        varInSection.append(Int(variance))
    }
    
    // TODO:
    private func isMotion(_ x: Double, _ y: Double, _ z: Double) -> Bool {
        let nX = 0.1
        let nY = 0.1
        let nZ = 0.1
        // TODO
        let xx = abs(x)
        let yy = abs(y)
        let zz = abs(z)
        if (xx < nX * 1.5 || xx > nX * 0.5) && (yy < nY * 1.5 || yy > nY * 0.5) && (zz < nZ * 1.5 || zz > nZ * 0.5) {
            return true
        }
        return false
    }
    
    //    private func getDataInSecond() async {
    //        var vx: [Double] = []
    //        var vy: [Double] = []
    //        var vz: [Double] = []
    //        for i in 0 ..< cntOneSecond {
    //            var tx = 0.0
    //            var ty = 0.0
    //            var tz = 0.0
    //            // TODO
    //            let length = Double(preDataInSecond[i].count)
    //            preDataInSecond[i].forEach { x, y, z in
    //                tx += x / length
    //                ty += y / length
    //                tz += z / length
    //            }
    //            if (i == 0) {
    //                vx.append(tx)
    //                vy.append(tx)
    //                vz.append(tx)
    //            } else {
    //                vx.append(vx[i - 1] + tx)
    //                vy.append(vy[i - 1] + ty)
    //                vz.append(vz[i - 1] + tz)
    //            }
    //            //            vx[i] = i > 0 ? vx[i - 1] + tx : tx
    //            //            vy[i] = i > 0 ? vy[i - 1] + ty : ty
    //            //            vz[i] = i > 0 ? vz[i - 1] + tz : tz
    //            dataInSecond.append(sqrt(vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]))
    //        }
    //    }
    
    
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
    

    
    private func getAvg(data: [Double]) -> Double {
        return data.reduce(0, +) / Double(data.count)
    }
    
    private func getAvg(data: [Int]) -> Int {
        return Int(Double(data.reduce(0, +)) / Double(data.count))
    }
}
