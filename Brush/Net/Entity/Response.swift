//
//  Response.swift
//  Brush
//
//  Created by cxq on 2023/8/2.
//

import Foundation


class Response<T: Codable>: Codable {
    
    var code: Int?
    var message: String?
    var data: T?
    
    
//    enum CodingKeys: String, CodingKey {
//        case code = "code"
//        case message = "message"
//        case data = "data"
//    }
    
    //    required init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        code = try values.decodeIfPresent(Int.self, forKey: .code)
    //        message = try values.decodeIfPresent(String.self, forKey: .message)
    //        data = try values.decodeIfPresent(T.self, forKey: .data)
    //    }
    
//    init (res:Data) throws{
//        let response = try JSONDecoder().decode(Response.self, from: res)
//        code = response.code
//        message = response.message
//        //data = response.data ?? "null" as! T
//    }
    
    
}
