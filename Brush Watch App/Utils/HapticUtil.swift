//
//  HapticUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/5.
//

import Foundation
import WatchKit

class HapticUtil {
    
    static private let device = WKInterfaceDevice.current()
    
    static func start() {
        device.play(.start)
    }
    
    static func stop() {
        device.play(.stop)
    }
    
    static func change() {
        device.play(.notification)
    }
    
    static func alert() {
        device.play(.failure)
    }
    
    static func click() {
        device.play(.directionDown)
    }
    
    static func getFromPhone() {
        device.play(.directionDown)
    }
    
    static func beat() {
        device.play(.success)
    }
    
    
}
