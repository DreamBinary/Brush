//
//  DataUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/29.
//

import Foundation

class DataUtil {
    private static let defaults = UserDefaults.standard
    
    static func saveUserId(_ userId: Int) {
        defaults.set(userId, forKey: "userId")
    }
    
    static func getUserId() -> Int? {
        return defaults.object(forKey: "userId") as? Int
    }
}
