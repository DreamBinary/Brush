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
    @State private var cSection: Section = .OLB
    @State private var isStarted: Bool = false
    var body: some View {
        let util: PhoneUtil = PhoneUtil { msg in
            if ((msg["start"] != nil) == true) {
                brushState = .start
                cSection = .OLB
                isStarted = true
                HapticUtil.getFromPhone()
            }
        }
        Group {
            switch brushState {
                case .start:
                    Start(isStarted: $isStarted) {
                        util.send2Phone(["start": true])
                        HapticUtil.change()
                        changePage()
                    }
//                case .count_down:
//                    CountDown() {
//                        changePage()
//                    }
                case .pre:
                    SectionPre(cSection).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            HapticUtil.start()
                            changePage()
                        }
                    }
                case .ing:
                    SectionIng(cSection).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            HapticUtil.change()
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
                        util.send2Phone(["finish": true])
                        cSection = .OLB
                        changePage()
                    }
                case .score:
                    Score {
                        changePage()
                    }
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
