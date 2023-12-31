//
//  WatchUtil.swift
//  Brush
//
//  Created by cxq on 2023/8/4.
//

import Foundation
import HealthKit
import WatchConnectivity

class WatchUtil: NSObject, WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    //    var onReceive: ([String : Any]) ->  Void
    private var session: WCSession = .default
    //    init(onReceive: @escaping ([String : Any]) -> Void = {_ in }) {
    //        self.onReceive = onReceive
    //        super.init()
    //        self.session.delegate = self
    //        session.activate()
    //    }
    override init() {
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func send2Watch(_ message: [String: Any], onSuccess: @escaping () -> Void) {
        if WCSession.isSupported() {
            session.sendMessage(message, replyHandler: { msg in
                if (msg["success"] != nil) as Bool == true {
                    onSuccess()
                }
            }, errorHandler: .none)
        }
    }
    
    func startApp(completion: @escaping (Bool, Error?) -> Void) {
        if isPaired() && isWatchAppInstalled() {
            let workoutConfiguration = HKWorkoutConfiguration()
            workoutConfiguration.locationType = .indoor
            workoutConfiguration.activityType = .other
            let healthStore = HKHealthStore()
            healthStore.startWatchApp(with: workoutConfiguration) { success, error in
                completion(success, error)
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        //        onReceive(message)
    }
    
    func activate() {
        session.activate()
    }
    
    //    WCSession is not reachable
    func isReachable() -> Bool {
        return session.isReachable
    }
    
    func isPaired() -> Bool {
        return session.isPaired
    }
    
    func isWatchAppInstalled() -> Bool {
        return session.isWatchAppInstalled
    }
}
