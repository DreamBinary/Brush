//
//  Url.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation


class Url {
    static private let baseUrl = "https://tunebrush-api.shawnxixi.icu"
    static let signUp = baseUrl + "/api/users/register"
    static let login = baseUrl + "/api/users/login"
    static let toothBrush = baseUrl + "/api/brush"
    static let scoreRecord = baseUrl + "/api/record"
    static let modifyPassword = baseUrl + "/api/users/change-password"
    static let updateUser = baseUrl + "/api/users/update"
}
