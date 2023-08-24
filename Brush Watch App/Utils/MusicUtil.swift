//
//  MusicUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/4.
//

import AVFoundation
import Foundation

class MusicUtil {
    private var player: AVPlayer?
    private var normalSpeed: Double = 0.33259184633785926
    private var vx = 0.0
    private var vy = 0.0
    private var vz = 0.0
    init(res: String) {
        if let url = Bundle.main.url(forResource: res, withExtension: "mp3") {
            self.player = AVPlayer(url: url)
        }
    }

    func play() {
        player?.volume = 1
        player?.seek(to: .zero)
        player?.play()
    }

    func changeVolumn(_ x: Double, _ y: Double, _ z: Double) {
        vx += x
        vy += y
        vz += z 
        let t: Double = sqrt(vx * vx + vy * vy + vz * vz)
        player?.volume = Float(0.9 * t / normalSpeed + 0.1)
    }

    func stop() {
        player?.pause()
    }
}
