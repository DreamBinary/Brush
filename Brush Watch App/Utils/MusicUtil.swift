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
    private var normalAcce: Double = 0.4039051074102969
    init(res: String) {
        if let url = Bundle.main.url(forResource: res, withExtension: "mp3") {
            self.player = AVPlayer(url: url)
        }
    }

    func play() {
        player?.volume = 0
        player?.seek(to: .zero)
        player?.play()
    }

    func changeVolumn(_ x: Double, _ y: Double, _ z: Double) {
        let t: Double = sqrt(x * x + y * y + z * z)
        player?.volume = 0
    }

    func stop() {
        player?.pause()
    }
}
