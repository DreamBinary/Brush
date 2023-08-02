//
//  User.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation

//"data": {
//    "email": "16477153539@qq.com",
//    "username": "牙牙守护者",
//    "avatar": 0,
//    "signature": "今天也要好好刷牙",
//    "id": 10018
//}


class User: Codable, Equatable {
    var email: String?
    var username: String?
    var avatar: Int?
    var signature: String?
    var id: Int?
    
    public var description: String {
        return "email:\(email ?? "") username:\(username ?? "") avatar:\(avatar ?? 0) signature:\(signature ?? "") id:\(id ?? 0)"
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case username = "username"
        case avatar = "avatar"
        case signature = "signature"
        case id = "id"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        avatar = try values.decodeIfPresent(Int.self, forKey: .avatar)
        signature = try values.decodeIfPresent(String.self, forKey: .signature)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
    init() {
        email = ""
        username = ""
        avatar = 0
        signature = ""
        id = 0
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email && lhs.username == rhs.username && lhs.avatar == rhs.avatar && lhs.signature == rhs.signature && lhs.id == rhs.id
    }
    
}
