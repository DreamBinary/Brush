////
////  BrushIng.swift
////  Brush Watch App
////
////  Created by cxq on 2023/7/20.
////
//
// import SwiftUI
//
// struct Brush: View {
//    @State private var brushState: BrushState = .start
//    @State private var cSection: Section = .ORT
//    @ObservedObject private var phoneUtil = PhoneUtil()
//    @State var player = MusicUtil(res: Section.ORT.rawValue)
//    var session = SessionUtil()
//
//
//    var body: some View {
//        switch brushState {
//            case .start:
//                Start(isStarted: $phoneUtil.isStarted) {
//                    HapticUtil.change()
//                    changePage()
//                }
//            case .pre:
//                SectionPre(cSection).onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        HapticUtil.start()
//                        changePage()
//                    }
//                }
//            case .ing:
//                SectionIng(cSection).onAppear {
//                    player.play()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
//                        HapticUtil.change()
//                        player.stop()
//                        player = MusicUtil(res: SectionUtil.getNext(cSection).rawValue)
//                        changePage()
//                    }
//                }
//            case .ed:
//                SectionEd(cSection).onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        changePage()
//                    }
//                }
//            case .finish:
//                Finish {
//                    cSection = .ORT
//                    changePage()
//                }
//            case .score:
//                Score {
//                    changePage()
//                }
//        }
//    }
//
//    func changePage() {
//        if brushState == .ed {
//            cSection = SectionUtil.getNext(cSection)
//        }
//        if cSection == .Finish {
//            brushState = .finish
//        } else {
//            brushState = {
//                switch brushState {
//                    case .start:
//                        return .pre
//                    case .pre:
//                        return .ing
//                    case .ing:
//                        return .ed
//                    case .ed:
//                        return .pre
//                    case .finish:
//                        return .score
//                    case .score:
//                        return .start
//                }
//            }()
//        }
//    }
// }
//
// enum BrushState {
//    case start
//    case pre
//    case ing
//    case ed
//    case finish
//    case score
// }
//
// struct BrushIng_Previews: PreviewProvider {
//    static var previews: some View {
//        Brush()
//    }
// }

//
//  BrushIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/20.
//

import SwiftUI

struct Brush: View {
    @ObservedObject private var util = BrushUtil()
//    @State var brushState: BrushState = .start
//    var cSection: Section = .ORT
    private var notificationCenter = NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)
    var body: some View {
        Group {
            switch util.brushState {
                case .start:
                    Start(
                        isStarted: $util.isStarted,
                        cnt: $util.cnt,
                        hasBeat: $util.hasBeat,
                        onStartTap: {
                            util.startBrush()
                        })
                case .pre:
                    SectionPre(util.cSection)
                case .ing:
                    SectionIng(util.cSection)
                case .ed:
                    SectionEd(util.cSection)
                case .finish:
                    Finish { util.finishBrush() }
                case .score:
                    Score(score: util.getBrushScore()) { util.changePage() }
//                    Score(score: ["powerScore": 90, "timeScore": 85, "sectionScore": 77], onBtnTap: { util.changePage() })
            }
        }.onReceive(notificationCenter) { _ in
            util.updateState()
        }
    }
}

struct BrushIng_Previews: PreviewProvider {
    static var previews: some View {
        Brush()
    }
}
