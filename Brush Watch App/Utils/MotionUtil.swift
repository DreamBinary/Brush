//
//  MotionUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/3.
//

import Foundation
import CoreMotion
import WatchKit

class MotionUtil {
    static private let motion = CMMotionManager()
    static private var timerAcce: Timer?
    static private var timerGyro: Timer?
    static private let interval = 1.0 / 20.0  // 20 Hz
    static func start( getAcceData: @escaping (Double, Double, Double) -> Void, getGyroData: @escaping (Double, Double, Double) -> Void) {
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = interval
            self.motion.startAccelerometerUpdates()
            self.timerAcce = Timer(fire: Date(), interval: interval, repeats: true, block: { _ in
                if let data = self.motion.accelerometerData {
                    //  value 1.0 representing an acceleration of 9.8 meters per second (per second) in the given direction
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    getAcceData(x, y, z)
                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timerAcce!, forMode: .default)
        }
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = interval
            motion.startGyroUpdates()
            self.timerGyro = Timer(fire: Date(), interval: interval, repeats: true, block: { _ in
                if let data = motion.gyroData {
                    let x = data.rotationRate.x
                    let y = data.rotationRate.y
                    let z = data.rotationRate.z
                    getGyroData(x, y, z)
                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timerGyro!, forMode: .default)
        }
    }
    
    static func stop() {
        if self.timerAcce != nil {
            self.timerAcce?.invalidate()
            self.timerAcce = nil
        }
        if self.timerGyro != nil {
            self.timerGyro?.invalidate()
            self.timerGyro = nil
        }
    }
    
    func getOnWrist() -> WKInterfaceDeviceWristLocation {
        return WKInterfaceDevice.current().wristLocation
    }
}
