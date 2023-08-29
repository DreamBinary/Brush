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
    
    private var userId: Int = -1
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
        reset()
        saveScore()
        print("TAG", "--------------", "finish")
    }
    
    private func saveScore()  {
        if (userId > 0) {
            Task {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                let brushTime = dateFormatter.string(from: .now)

                let url: String = "https://tunebrush-api.shawnxixi.icu/api/record"
                let score: ScoreEntity = scoreUtil.getSaveScore()
                let _: Response<Int?> = try await ApiClient.request(url, method: .POST, params: [
                    "userId": userId,
                    "brushTime": brushTime,
                    "timeScore": score.timeScore,
                    "powerScore": score.powerScore,
                    "powerScoreList": score.powerScoreList
                ])
            }
        }
    }
    
    private func processData(_ x: Double, _ y: Double, _ z: Double) {
        self.scoreUtil.getPreDataInSecond(x: x, y: y, z: z)
        self.musicUtil.changeVolumn(x, y, z)
        // TODO
    }
    
    func reset() {
        self.cSection = .ORT
        self.cnt = 3
        self.isStarted = false
        self.musicUtil = MusicUtil(res: Section.ORT.rawValue)
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
    
    func changePage() {
        DispatchQueue.main.async {
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
    }
    
    
    func session(_ session: WCSession,
                 didReceiveMessage message: [String: Any],
                 replyHandler: @escaping ([String: Any]) -> Void) {
        if message["userId"] != nil {
            userId = message["userId"] as! Int
            HapticUtil.getFromPhone()
            startBrush()
            replyHandler(["success": true])
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
