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
    // TODO
    private var normalAcce: Double = 0.0038730531610324487
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

    // TODO
    func changeVolumn(_ x: Double, _ y: Double, _ z: Double) {
        let t: Double = sqrt(x * x + y * y + z * z)
        player?.volume = min(Float(0.9 * t / normalAcce + 0.1), 10)
    }

    func stop() {
        player?.pause()
    }
}
