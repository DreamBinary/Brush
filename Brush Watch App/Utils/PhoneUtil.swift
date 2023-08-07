//
//  PhoneUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/3.
//

import Foundation
import WatchConnectivity

class PhoneUtil: NSObject, WCSessionDelegate {
    var onReceive: ([String: Any]) -> Void
    private var session: WCSession = .default
    init(onReceive: @escaping ([String: Any]) -> Void = { _ in }) {
        self.onReceive = onReceive
        super.init()
        session.delegate = self
        session.activate()
    }
    
    
    
//    func send2Phone(_ message: [String: Any]) {
//        if WCSession.isSupported() {
//            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
//        } else {
//            print("WCSession is not supported")
//        }
//    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        onReceive(message)
    }
}
