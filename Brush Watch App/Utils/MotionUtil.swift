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
    static let motion = CMMotionManager()
    static var timer: Timer?
    static private var interval = 1.0 / 20.0  // 20 Hz
    static func startAccelerometers( getData: @escaping (Double, Double, Double) -> Void) {
        
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = interval
            self.motion.startAccelerometerUpdates()
            
            self.timer = Timer(fire: Date(), interval: interval,
                               repeats: true, block: { _ in
                if let data = self.motion.accelerometerData {
                    //                    value 1.0 representing an acceleration of 9.8 meters per second (per second) in the given direction
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
                    //                    getData(x, y, z)
                    getPower(x: x, y: y, z: z)
                }
                
                if motion.isGyroAvailable {
                    motion.gyroUpdateInterval = interval
                    motion.startGyroUpdates()
                    if let data = motion.gyroData {
                        
                        let x = data.rotationRate.x
                        let y = data.rotationRate.y
                        let z = data.rotationRate.z
                        getData(x, y, z)
                    }
                }
                
                //                if motionManager.isGyroAvailable {
                //                    motionManager.gyroUpdateInterval = 0.1  // 设置采样率，单位为秒
                //                    motionManager.startGyroUpdates(to: OperationQueue.main) { (gyroData, error) in
                //                        if let gyroData = gyroData {
                //                            let rotationRate = gyroData.rotationRate
                //                            // 在这里处理陀螺仪数据，rotationRate包含x、y、z轴上的旋转速度
                //                        }
                //                    }
                //                } else {
                //                    print("陀螺仪不可用")
                //                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: .default)
        } else {
            print("disable")
        }
    }
    
    static func getPower(x xx: Double, y yy: Double, z zz: Double) {
        let x = abs(xx)
        let y = abs(yy)
        let z = abs(zz) - 1
        
        let xyz = sqrt(x * x + y * y + z * z) * 9.8
        print(x, y, z, xyz)
    }
    
    static func stopAccelerometers() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
        }
    }
    
    func getOnWrist() -> WKInterfaceDeviceWristLocation {
        return WKInterfaceDevice.current().wristLocation
    }
}
