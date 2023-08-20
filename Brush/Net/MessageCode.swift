//
//  ErrorCode.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/8/21.
//

enum ErrorCode: Int {
    case badRequest = 450
    case userNotFound = 451
    case wrongPassword = 452
    case invalidEmailFormat = 453
    case emailAlreadyExists = 454
    case registrationFailed = 455
    
    var message: String {
        switch self {
        case .badRequest:
            return "请求参数错误"
        case .userNotFound:
            return "用户不存在"
        case .wrongPassword:
            return "密码错误"
        case .invalidEmailFormat:
            return "邮箱格式非法"
        case .emailAlreadyExists:
            return "邮箱已存在"
        case .registrationFailed:
            return "注册失败"
        }
    }
}

enum SuccessMessage: String {
    case register = "注册成功"
    case login = "登录成功"
    case dataLoaded = "数据加载成功"
    // 添加其他成功消息...
}
