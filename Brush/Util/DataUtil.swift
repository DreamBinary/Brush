//
//  DataUtil.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation


class DataUtil {
    
    static func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
        }
    }
    
    static func getUser() -> User? {
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(User.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return nil
    }
    
    static func clearUser() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
    }
    
}
