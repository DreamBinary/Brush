//
//  ToothBrush.swift
//  Brush
//
//  Created by cxq on 2023/8/24.
//

import Foundation

class ToothBrushEntity: Codable, Identifiable, Equatable {
    static func == (lhs: ToothBrushEntity, rhs: ToothBrushEntity) -> Bool {
        return lhs.id == rhs.id
    }

    var daysUsed: Int = -1
    var daysRemaining: Int = -1
}
