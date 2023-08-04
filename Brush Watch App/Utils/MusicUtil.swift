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
    
    init(res: String) {
        if let url = Bundle.main.url(forResource: res, withExtension: "mp3") {
            self.player = AVPlayer(url: url)
        }
    }
    
    func play() {
        player?.seek(to: .zero)
        player?.play()
    }
    
    func stop() {
        player?.pause()
    }
}
