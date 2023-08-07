////
////  Logger.swift
////  Brush Watch App
////
////  Created by cxq on 2023/8/3.
////
//
//
//import SwiftUI
//import CocoaLumberjackSwift
//
//
//class Logger {
//    static var path: String?
//    static func config() {
//        // 配置日志输出
//        DDLog.add(DDOSLogger.sharedInstance) // 输出到控制台
//        
//        // 设置文件日志的保存位置和相关配置
//        let fileLogger = DDFileLogger()
//        fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24) // 24小时滚动一次文件
//        fileLogger.logFileManager.maximumNumberOfLogFiles = 7 // 最多保存7天的日志文件
//        fileLogger.maximumFileSize = 1024 * 1024 * 100 // 100 MB
//        path = fileLogger.logFileManager.logsDirectory
//        print("\(fileLogger.logFileManager.description)")
//        print("\(fileLogger.logFileManager.logsDirectory)")
//        
//        // 添加文件日志输出
//        DDLog.add(fileLogger)
//    }
//    
//    
//    static func logi(_ message: String) {
//        DDLogInfo(message)
//    }
//}
//
