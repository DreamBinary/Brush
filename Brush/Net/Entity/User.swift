//
//  User.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation

//{
//    "code": 200,
//    "message": "登录成功",
//    "data": {
//        "id": 10031,
//        "email": "tunebrush@shawnxixi.icu",
//        "username": "牙牙守护者",
//        "avatar": 0,
//        "signature": "今天也要好好刷牙",
//        "registerTime": "2023-08-18T13:00:48.000+00:00"
//    }
//}

struct User: Codable, Equatable {
    var email: String?
    var username: String?
    var avatar: Int?
    var signature: String?
    var id: Int?
    var registerTime: Date?
    
//    public var description: String {
//        return """
//        email = \(email ?? "")
//        username = \(username ?? "")
//        avatar = \(avatar ?? 0)
//        signature = \(signature ?? "")
//        id = \(id ?? 0)
//        registerTime = \(registerTime ?? Date())
//        """
//    }
//
//
//    enum CodingKeys: String, CodingKey {
//        case email = "email"
//        case username = "username"
//        case avatar = "avatar"
//        case signature = "signature"
//        case id = "id"
//        case registerTime = "registerTime"
//    }
//
//    init(email: String? = "", username: String? = "", avatar: Int? = 0, signature: String? = "", id: Int? = 0, registerTime: Date? = Date()) {
//        self.email = email
//        self.username = username
//        self.avatar = avatar
//        self.signature = signature
//        self.id = id
//        self.registerTime = registerTime
//    }
    
    
    //    required init(from decoder: Decoder) throws {
    //        print("2222222222")
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        email = try values.decodeIfPresent(String.self, forKey: .email)
    //        username = try values.decodeIfPresent(String.self, forKey: .username)
    //        avatar = try values.decodeIfPresent(Int.self, forKey: .avatar)
    //        signature = try values.decodeIfPresent(String.self, forKey: .signature)
    //        id = try values.decodeIfPresent(Int.self, forKey: .id)
    //
    //        print(email, username, avatar, signature, id)
    //    }
    
    
    //    required init(from decoder: Decoder) throws {
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.email = try container.decodeIfPresent(String.self, forKey: .email)
    //        self.username = try container.decodeIfPresent(String.self, forKey: .username)
    //        self.avatar = try container.decodeIfPresent(Int.self, forKey: .avatar)
    //        self.signature = try container.decodeIfPresent(String.self, forKey: .signature)
    //        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    //    }
}
