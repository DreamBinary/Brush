//
//  DataUtil.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation


class DataUtil {
    static private let defaults = UserDefaults.standard
    
    static func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: "user")
        }
    }
    
    static func getUser() -> User? {
        if let savedPerson = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(User.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return nil
    }
    
    static func getLogin() -> Bool {
        let isLogin: Bool? = defaults.object(forKey: "login") as? Bool
        return isLogin ?? false
    }
    
    static func setLogin() {
        defaults.set(true, forKey: "login")
    }
    
    static func removeAll() {
        defaults.removeObject(forKey: "user")
        defaults.removeObject(forKey: "login")
    }
}
