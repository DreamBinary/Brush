//
//  Start.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct Start: View {
    @Binding var isStarted: Bool
    var onCountdownEnd: () -> Void
 
    var body: some View {
        BgColor(.primary) {
            ZStack {
                if !isStarted {
                    AnimViolin().transition(.opacity)
                }
                
                AnimNote()

                if isStarted {
                    CountDown {
                        onCountdownEnd()
                        isStarted = false
                    }.transition(.opacity)
                } else {
                    Text("Start!")
                        .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.5))
                        .fontWeight(.bold)
                        .onTapGesture {
                            HapticUtil.click()
                            isStarted = true
                        }.transition(.opacity)
                }
            }
        }
    }
}

//struct Start_Previews: PreviewProvider {
//    static var previews: some View {
//        Start(isStarted: false) {}
//    }
//}
