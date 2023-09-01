//
//  ListUtil.swift
//  Brush
//
//  Created by cxq on 2023/8/30.
//

import Foundation

class ListUtil {
    static func findMinIndices(_ array: [Int], _ count: Int) -> [Int] {
        guard count > 0, count <= array.count else {
            return []
        }

        var indices: [Int] = []
        let sortedArray = array.enumerated().sorted { $0.element < $1.element }

        for i in 0 ..< count {
            indices.append(sortedArray[i].offset)
        }

        return indices
    }
}
