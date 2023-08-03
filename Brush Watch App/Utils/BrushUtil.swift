//
//  BrushUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/3.
//

import Foundation
import CoreMotion
import WatchKit

class BrushUtil {
    let motion = CMMotionManager()
    var timer: Timer?
    
    func startAccelerometers( getData: @escaping (Double, Double, Double) -> Void) {
        // Make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 50.0  // 50 Hz
            self.motion.startAccelerometerUpdates()
            
            
            // Configure a timer to fetch the data.
            self.timer = Timer(fire: Date(), interval: (1.0/50.0),
                               repeats: true, block: { (timer) in
                // Get the accelerometer data.
                if let data = self.motion.accelerometerData {
                    let x :Double = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    getData(x, y, z)
                    print(x, y, z)
                    // Use the accelerometer data in your app.
                }
            })
            
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: .default)
        } else {
            print("disable")
        }
    }
    
    func stopAccelerometers() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
        }
    }
    
    func getOnWrist() -> WKInterfaceDeviceWristLocation {
        return WKInterfaceDevice.current().wristLocation
//    case left = 0
//    case right = 1
    }
}
