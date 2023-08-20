//
//  APIService.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/8/20.
//
// 文档：https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md

import Foundation
import Moya

enum ApiService {
    case login(email:String,password:String)
    case signUp(email:String,password:String)
}

// MARK: - TargetType Protocol Implementation
extension ApiService: TargetType {
    var baseURL: URL { return URL(string: "https://tunebrush-api.shawnxixi.icu")! }
//    var baseURL: URL { return URL(string: "http://127.0.0.1:8099")! }
    var path: String {
        switch self {
        case .login(_ , _):
            return "/api/users/login"
        case .signUp(_ , _):
            return "/api/users/register"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .login(email ,password):
            return .requestParameters(parameters: ["email": email, "plainPassword": password], encoding: JSONEncoding.default)
        case let .signUp(email ,password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        Data(self.utf8)
    }
}


// MARK: - example
//provider.request(target) { result in
//    switch result {
//    case let .success(response):
//        // Do sg on success
//    case let .failure(error):
//        // Handle error here
//    }
//}
