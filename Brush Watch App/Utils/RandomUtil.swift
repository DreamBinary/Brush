//
//  RandomUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/21.
//

import Foundation


class RandomUtil {
    
    static func rDouble() -> Double{
        return Double.random(in: -1...1)
    }
    
    static func rSelect<T>(data: [T], num: Int) -> [T] {
        if (data.count <= num) {
            return data
        }
        var result = [T]()
        var data = data
        for _ in 0..<num {
            let index = Int(arc4random_uniform(UInt32(data.count)))
            result.append(data[index])
            data.remove(at: index)
        }
        return result
    }
}
