//
//  Start.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct Start: View {
    var onStart: () -> Void
    @State var isStarted = false
    var body: some View {
        BgColor(.primary) {
            ZStack {
                AnimViolin()
                
                if !isStarted {
                    AnimNote()
                }

                if isStarted {
                    CountDown {
                        onStart()
                    }
                } else {
                    Text("Start!")
                        .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.5))
                        .fontWeight(.bold)
                        .onTapGesture {
                            isStarted.toggle()
                        }
                }
            }
        }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start {}
    }
}
