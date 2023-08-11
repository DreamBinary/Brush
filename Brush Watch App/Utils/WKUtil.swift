//
//  WKUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/11.
//

import Foundation
import SwiftUI
import WatchKit

class SessionUtil: NSObject, WKExtendedRuntimeSessionDelegate {
    private var session: WKExtendedRuntimeSession?
    func start() {
        guard session?.state != .running else { return }
        
        // create or recreate session if needed
        if session == nil || session?.state == .invalid {
            session = WKExtendedRuntimeSession()
            session?.delegate = self
        }
        session?.start()
    }
    
    func invalidate() {
        session?.invalidate()
    }
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
         
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            print("timer")
        }
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
         
    }
}
