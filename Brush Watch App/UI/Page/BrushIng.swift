//
//  BrushIng.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/20.
//

import SwiftUI

struct BrushIng: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var brushState: BrushState = .start
    @State var cSection : Section = .OLB
    var body: some View {
        Group{
            switch brushState {
                case .start:
                    Start().onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            changePage()
                        }
                    }
                case .pre:
                    SectionPre(cSection).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            changePage()
                        }
                    }
                case .ing:
                    SectionIng(cSection).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            changePage()
                        }
                    }
                case .ed:
                    SectionEd(cSection).onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            changePage()
                        }
                    }
                case .finish:
                    Finish {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
    
    private func changePage() {
        if (brushState == .ed) {
            cSection = SectionUtil.getNext(cSection)
        }
        if (cSection == .Finish) {
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
                        return .finish
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
}

struct BrushIng_Previews: PreviewProvider {
    static var previews: some View {
        BrushIng()
    }
}
