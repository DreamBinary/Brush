//
//  SpeakUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/20.
//

import AVFoundation


class SpeakUtil {
    static let shared = SpeakUtil()
    
    private var synthesizer: AVSpeechSynthesizer?
    
    private init() {
        synthesizer = AVSpeechSynthesizer()
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        
        
        // 使用下面的方法获取设备上所有可用的语音列表
        let voices = AVSpeechSynthesisVoice.speechVoices()
//        print(voices)
        
        // 在语音列表中选择你想要的声音，例如中文的普通话女声
        if let voice = voices.first(where: { $0.name == "com.apple.ttsbundle.siri_female_zh-CN_compact" }) {
            utterance.voice = voice
        } else {
            // 如果指定的语音不存在，可以使用默认语音
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        }
        
//        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.rate = 0.7
        synthesizer?.speak(utterance)
    }
    
    func stop() {
        synthesizer?.stopSpeaking(at: .immediate)
    }
}
