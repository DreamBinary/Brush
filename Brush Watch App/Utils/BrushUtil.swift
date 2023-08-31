//
//  BrushUtil.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/15.
//

import Combine
import Foundation
import SwiftUI
import WatchConnectivity

class BrushUtil: NSObject, ObservableObject, WCSessionDelegate {
    @Published var brushState: BrushState = .start
    @Published var cSection: Section = .ORT
    @Published var cnt: Int = 3
    @Published var isStarted = false
    @Published var hasBeat = false
    private var musicUtil = MusicUtil(res: Section.ORT.rawValue)
    private var scoreUtil = ScoreUtil()
    private lazy var bgRun = BgRunUtil(onStart: {
        Task {
            DispatchQueue.main.async {
                self.isStarted = true
            }
            while self.cnt > 0 {
                SpeakUtil.shared.speak("\(self.cnt)")
                try await Task.sleep(for: .seconds(1))
                self.cnt -= 1
            }
            await self.brush()
        }
    })
    
    private var session: WCSession = .default
    
    override init() {
        super.init()
        session.delegate = self
        session.activate()
    }
    
    private func brush() async {
        changePage()
        while brushState != .finish {
            sleep(1)
            musicUtil.play()
            MotionUtil.start(getAcceData: { x, y, z in
                self.processData(x, y, z)
            })
            HapticUtil.start()
            changePage()
            await withTaskGroup(of: Void.self) { group in
                if (hasBeat) {
                    group.addTask {
                        await self.beatTip()
                    }
                }
                group.addTask {
                    await self.timeCount()
                }
            }
            
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
        MotionUtil.stop()
        reset()
        saveScore()
    }
    
    private func beatTip() async {
        for _ in 0 ... 6 {
            try! await Task.sleep(for: .milliseconds(1375))
            HapticUtil.beat()
        }
    }
    
    private func timeCount() async {
        for _ in 0 ... 10 {
            try! await Task.sleep(for: .seconds(1))
            scoreUtil.addSecond()
        }
    }
    
    private func saveScore() {
        let score: ScoreEntity = scoreUtil.getSaveScore()
        if score.userId != -1 {
            Task {
                let url: String = "https://tunebrush-api.shawnxixi.icu/api/record"
                let response: Response<Int?> = try await ApiClient.request(url, method: .POST, param: score)
                // TODO
//                print("TAG", "response", response.code)
//                print("TAG", "response", response.message)
//                print("TAG", "response", response.data)
            }
        }
    }
    
    private func processData(_ x: Double, _ y: Double, _ z: Double) {
        scoreUtil.getPreDataInSecond(x: x, y: y, z: z)
        musicUtil.changeVolumn(x, y, z)
    }
    
    func reset() {
        cSection = .ORT
        cnt = 3
        isStarted = false
        musicUtil = MusicUtil(res: Section.ORT.rawValue)
    }
    
    func startBrush() {
        bgRun.start()
    }
    
    func finishBrush() {
        bgRun.stop()
        changePage()
    }
    
    func getBrushScore() -> [String: Int] {
        return scoreUtil.getScore()
    }
    
    func updateState() {
        DispatchQueue.main.async {
            self.brushState = self.brushState
            self.cSection = self.cSection
        }
    }
    
    func changePage() {
            if self.brushState == .ed {
                self.cSection = SectionUtil.getNext(self.cSection)
            }
            if self.cSection == .Finish {
                self.brushState = .finish
            } else {
                self.brushState = {
                    switch self.brushState {
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
    
    func session(_ session: WCSession,
                 didReceiveMessage message: [String: Any],
                 replyHandler: @escaping ([String: Any]) -> Void)
    {
        if message["userId"] != nil {
            replyHandler(["success": true])
            let userId = message["userId"] as! Int
            let hasBeat = message["hasBeat"] as! Bool
            DispatchQueue.main.async {
                self.hasBeat = hasBeat
            }
            HapticUtil.getFromPhone()
            startBrush()
            DataUtil.saveUserId(userId)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}

enum BrushState {
    case start
    case pre
    case ing
    case ed
    case finish
    case score
}
