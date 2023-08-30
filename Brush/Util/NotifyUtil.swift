////
////  NotifyUtil.swift
////  Brush
////
////  Created by cxq on 2023/8/23.
////
//
//import Foundation
//import UserNotifications
//
//class NotifyUtil {
//    
//    func askPermissin() {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
//            if (granted) {
//                print("授权成功")
//            } else {
//                print("授权失败")
//            }
//        }
//    }
//    
//    
//    
//    func send() {
//        let content = UNMutableNotificationContent()
//        content.title = "通知标题"
//        content.body = "通知内容"
//        content.badge = 1
//        
//        content.sound = UNNotificationSound.default
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "cxq", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
//    }
//    
//    
//}
