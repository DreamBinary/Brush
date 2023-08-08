//
//  BrushIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/20.
//

import SwiftUI

struct Brush: View {
//    @Environment(\.presentationMode) var presentationMode

    @State private var brushState: BrushState = .start
    @State private var cSection: Section = .ORT
    @ObservedObject private var util = PhoneUtil()
    @State var player = MusicUtil(res: Section.ORT.rawValue)
    var body: some View {
        switch brushState {
            case .start:
                Start(isStarted: $util.isStarted) {
                    MotionUtil.startAccelerometers { _, _, _ in }
                    HapticUtil.change()
                    changePage()
                }
//                case .count_down:
//                    CountDown() {
//                        changePage()
//                    }
            case .pre:
                SectionPre(cSection).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        HapticUtil.start()
                        changePage()
                    }
                }
            case .ing:
                SectionIng(cSection).onAppear {
                    player.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                        HapticUtil.change()
                        player.stop()
                        player = MusicUtil(res: SectionUtil.getNext(cSection).rawValue)
                        changePage()
                    }
                }
            case .ed:
                SectionEd(cSection).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        changePage()
                    }
                }
            case .finish:
                Finish {
                    cSection = .OLB
                    changePage()
                }
            case .score:
                Score {
                    changePage()
                }
        }
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
//                        return .count_down
//                    case .count_down:
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
//    case count_down
    case pre
    case ing
    case ed
    case finish
    case score
}

struct BrushIng_Previews: PreviewProvider {
    static var previews: some View {
        Brush()
    }
}
