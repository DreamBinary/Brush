//
//  BrushUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/15.
//

import Combine
import Foundation
import SwiftUI

class BrushUtil: ObservableObject {
    @Published var brushState: BrushState = .start
    @Published var cSection: Section = .ORT
    @Published var cnt: Int = 3
    @Published var isStarted = false
    lazy var phoneUtil = PhoneUtil(onStart: self.startBrush)
    private var musicUtil = MusicUtil(res: Section.ORT.rawValue)
    private var scoreUtil = ScoreUtil()
    
    private lazy var bgRun = BgRunUtil(onStart: {
        Task {
            self.isStarted = true
            while self.cnt > 0 {
                SpeakUtil.shared.speak("\(self.cnt)")
                try await Task.sleep(for: .seconds(1))
                self.cnt -= 1
            }
            await self.brush()
        }
    }, onStop: {
        self.brushState = .start
        self.cSection = .ORT
        self.cnt = 3
        self.isStarted = false
        self.musicUtil = MusicUtil(res: Section.ORT.rawValue)
    })
    
    private func brush() async {
        changePage()
        while brushState != .finish {
            sleep(1)
            HapticUtil.start()
            changePage()
            musicUtil.play()
            MotionUtil.start(getAcceData: { x, y, z in
                self.scoreUtil.getPreDataInSecond(x: x, y: y, z: z)
            })
            sleep(11)
            MotionUtil.stop()
            musicUtil.stop()
            musicUtil = MusicUtil(res: SectionUtil.getNext(cSection).rawValue)
            HapticUtil.change()
            changePage()
            Task {
                await scoreUtil.sectionProcces()
            }
            sleep(1)
            changePage()
        }
    }
    
    func startBrush() {
        bgRun.start()
    }
    
    func finishBrush() {
        cSection = .ORT
        changePage()
        bgRun.stop()
    }
    
    func getBrushScore() -> [String: Int] {
        return scoreUtil.getScore()
    }
    
    func changePage() {
        if brushState == .ed {
            cSection = SectionUtil.getNext(cSection)
        }
        if cSection == .Finish {
            brushState = .finish
        } else {
            brushState = {
                switch brushState {
                    case .start:
                        return .pre
                    case .pre:
                        return .ing
                    case .ing:
                        return .ed
                    case .ed:
                        return .pre
                    case .finish:
                        return .score
                    case .score:
                        return .start
                }
            }()
        }
    }
}

enum BrushState {
    case start
    case pre
    case ing
    case ed
    case finish
    case score
}
