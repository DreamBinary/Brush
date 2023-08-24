//
//  Response.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/24.
//

import Foundation

class Response<T: Codable>: Codable {
    var code: Int?
    var message: String?
    var data: T?
}
