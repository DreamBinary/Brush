//
//  MotionUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/3.
//

import CoreMotion
import Foundation
import WatchKit

class MotionUtil {
    private static let motion = CMMotionManager()
//    private static var timerAcce: Timer?
//    static private var timerGyro: Timer?
    private static let interval = 1.0 / 60.0 // 60 Hz
    static func start(getAcceData: @escaping (Double, Double, Double) -> Void) {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = interval
            motion.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical, to: .current ?? .main, withHandler:{ (motionData, error) in
                if let data = motionData {
                    let x = data.userAcceleration.x
                    let y = data.userAcceleration.y
                    let z = data.userAcceleration.z
                    getAcceData(x, y, z)
                } else {
                    print("TAG", "error")
                    print(error)
                }
                
            })
//            timerAcce = Timer(fire: Date(), interval: interval, repeats: true, block: { _ in
////                            print("TAG", "heading", motion.deviceMotion?.heading ?? 0)
//                if let data = self.motion.deviceMotion {
//                    //  value 1.0 representing an acceleration of 9.8 meters per second (per second) in the given direction
//                    let x = data.userAcceleration.x
//                    let y = data.userAcceleration.y
//                    let z = data.userAcceleration.z
//                    getAcceData(x, y, z)
//                }
//            })
//            RunLoop.current.add(self.timerAcce!, forMode: .default)
//            RunLoop.current.run()
        }
//        else {
//            timerAcce = Timer(fire: Date(), interval: interval, repeats: true, block: { _ in
//                getAcceData(0.1, 0.2, 0.1)
//            })
//            RunLoop.current.add(self.timerAcce!, forMode: .default)
//            RunLoop.current.run()
//        }
        
//        if self.motion.isAccelerometerAvailable {
//            self.motion.accelerometerUpdateInterval = interval
//            self.motion.startAccelerometerUpdates()
//            self.timerAcce = Timer(fire: Date(), interval: interval, repeats: true, block: { _ in
//                if let data = self.motion.accelerometerData {
//                    //  value 1.0 representing an acceleration of 9.8 meters per second (per second) in the given direction
//                    let x = data.acceleration.x
//                    let y = data.acceleration.y
//                    let z = data.acceleration.z
//                    getAcceData(x, y, z)
//                }
//            })
//            // Add the timer to the current run loop.
//            RunLoop.current.add(self.timerAcce!, forMode: .default)
//        }
//        if motion.isGyroAvailable {
//            motion.gyroUpdateInterval = interval
//            motion.startGyroUpdates()
//            self.timerGyro = Timer(fire: Date(), interval: interval, repeats: true, block: { _ in
//                if let data = motion.gyroData {
//                    let x = data.rotationRate.x
//                    let y = data.rotationRate.y
//                    let z = data.rotationRate.z
//                    getGyroData(x, y, z)
//                }
//            })
//            // Add the timer to the current run loop.
//            RunLoop.current.add(self.timerGyro!, forMode: .default)
//        }
    }
    
    static func stop() {
        print("TAG", "stop MotionUpdate")
        self.motion.stopDeviceMotionUpdates()
//        if timerAcce != nil {
//            timerAcce?.invalidate()
//            timerAcce = nil
//        }
        
//        if self.timerGyro != nil {
//            self.timerGyro?.invalidate()
//            self.timerGyro = nil
//        }
    }
    
    func getOnWrist() -> WKInterfaceDeviceWristLocation {
        return WKInterfaceDevice.current().wristLocation
    }
}
