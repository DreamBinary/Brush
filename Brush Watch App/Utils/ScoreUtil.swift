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
    private var time = 0 // total time is 11 * 12 = 132v
    private var preDataInSecond: [(Double, Double, Double)] = []
    
    func getPreDataInSecond(x: Double, y: Double, z: Double) {
        preDataInSecond.append((x, y, z))
    }
    
    func secondProcess() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.computeTime()
            }
            group.addTask {
                await self.computePower()
            }
        }
        preDataInSecond.removeAll()
    }
    
    func sectionProces() async {
        await computeScoreInSection()
        dataInSecond.removeAll()
    }
    
    private func computeTime() async {
        var cnt = 0
        preDataInSecond.forEach { (x, y, z) in
            if (isMotion(x, y, z)) {
                cnt += 1
            }
        }
        if (cnt * 2 > preDataInSecond.count) {
            time += 1
        }
    }
    
    private func computePower() async {
        let datas = await getDataInSecond()
        await computeDataInSecond(datas: datas)
    }
    
    // TODO
    private func isMotion(_ x: Double, _ y: Double, _ z: Double) -> Bool { 
        return false
    }
    
    // TODO
    private func getDataInSecond() async -> [Double] {
        let datas: [Double] = []
        preDataInSecond.forEach { (x, y, z) in
            
        }
        return datas
    }
    
    private func computeDataInSecond(datas: [Double]) async -> Void {
        let length = datas.count
        let start = Int(length / 6) //  1 / 6
        let end = start * 5 //  5 / 6
        let datasTmp: [Double] = Array(datas.sorted()[start ..< end])
        print(datasTmp)
        let avg = getAvg(data: datasTmp)
        dataInSecond.append(avg)
    }
    
    private func computeScoreInSection() async {
        var datasTmp: [Double] = []
        dataInSecond.forEach { data in
            datasTmp.append(computeScoreInSecond(data: data))
        }
        dataInSecond.removeAll()
        let avg = getAvg(data: datasTmp)
        scoreInSection.append(avg)
    }
    
    private func getAvg(data: [Double]) -> Double {
        return data.reduce(0, +) / Double(data.count)
    }
    
    private func computeScoreInSecond(data: Double) -> Double {
        return 0.1
    }
}
