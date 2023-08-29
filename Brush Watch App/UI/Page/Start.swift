//
//  Start.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct Start: View {
    @Binding var isStarted: Bool
    @Binding var cnt: Int
    @Binding var hasBeat: Bool
    var onStartTap: () -> Void
 
    var body: some View {
        BgColor(.primary) {
            ZStack {
                if !isStarted {
                    AnimViolin().transition(.opacity)
                }
                AnimNote()
                if isStarted {
                    CountDown(cnt: $cnt).transition(.opacity)
                } else {
                    Text("Start!")
                        .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.5))
                        .fontWeight(.bold)
                        .onTapGesture {
                            HapticUtil.click()
                            onStartTap()
                        }.transition(.opacity)
                }
                
                HStack {
                    VStack {
                        HStack(spacing: 0) {
                            Text("节拍器").font(.footnote)
                            Image(systemName: hasBeat ? "checkmark.circle" :"circle")
                        }.onTapGesture {
                            hasBeat.toggle()
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

//struct Start_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var isStarted = false
//        @State var cnt = 3
//        Start(isStarted: $isStarted, cnt: $cnt, onStartTap: {})
//    }
//}
