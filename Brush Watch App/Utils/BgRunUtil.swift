//
//  WKUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/11.
//

import Foundation
import SwiftUI
import WatchKit

class BgRunUtil: NSObject, WKExtendedRuntimeSessionDelegate {
    var onStart: () -> Void
    private var session: WKExtendedRuntimeSession?
    
    init(onStart: @escaping () -> Void) {
        self.onStart = onStart
        super.init()
        
    }
    
    func start() {
        guard session?.state != .running else { return }
        if (session == nil || session!.state != .running) {
            session = WKExtendedRuntimeSession()
            session!.delegate = self
        }
        session?.start(at: Date())
    }
    
    func stop() {
        session?.invalidate()
    }
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        print("extendedRuntimeSession")
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        onStart()
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        print("extendedRuntimeSessionWillExpire")
    }
}
