////
////  PhoneUtil.swift
////  Brush Watch App
////
////  Created by cxq on 2023/8/3.
////
//
//import Foundation
//import WatchConnectivity
//
//class PhoneUtil: NSObject, WCSessionDelegate {
//    var onStart: () -> Void
//    var userId: Int = -1
//    private var session: WCSession = .default
//
//    init(isStarted: Bool = false, onStart: @escaping () -> Void = {}) {
//        self.onStart = onStart
//        super.init()
//        session.delegate = self
//        session.activate()
//    }
//
//    //    func send2Phone(_ message: [String: Any]) {
//    //        if WCSession.isSupported() {
//    //            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
//    //        } else {
//    //            print("WCSession is not supported")
//    //        }
//    //    }
//
//    func session(_ session: WCSession,
//                 didReceiveMessage message: [String: Any],
//                 replyHandler: @escaping ([String: Any]) -> Void) {
//        if message["userId"] != nil {
//            userId = message["userId"] as! Int
//            HapticUtil.getFromPhone()
//            onStart()
//            replyHandler(["success": true])
//        }
//    }
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
//
//    //    func session(_ session: WCSession, didReceiveMessage message: [String: Any], re) {
//    //        print("session")
//    //        if (message["start"] != nil) == true {
//    //            print("start")
//    //            HapticUtil.getFromPhone()
//    //            isStarted = true
//    //        }
//    //    }
//}
