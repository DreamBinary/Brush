//
//  WatchUtil.swift
//  Brush
//
//  Created by cxq on 2023/8/4.
//

import Foundation
import WatchConnectivity

class WatchUtil: NSObject, WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
      
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
 
    }
    
    var onReceive: ([String : Any]) ->  Void
    private var session: WCSession = .default
    init(onReceive: @escaping ([String : Any]) -> Void = {_ in }) {
        self.onReceive = onReceive
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func send2Watch(_ message: [String: Any]) {
        if WCSession.isSupported() {
            session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        } else {}
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        onReceive(message)
    }
    
//    WCSession is not reachable
    func isReachable()-> Bool {
        return session.isReachable
    }
    
    func isPaired() -> Bool {
        return session.isPaired
    }
    
    func isWatchAppInstalled() -> Bool {
        return session.isWatchAppInstalled
    }
}


