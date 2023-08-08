//
//  StartBrush.swift
//  Brush
//
//  Created by cxq on 2023/8/1.
//

import SwiftUI

struct StartBrush: View {
    var onStart: () -> Void
    let util = WatchUtil()
    @State private var isPresented: Bool = false
    @State private var msg: String = ""
    var body: some View {
        BgColor {
            GeometryReader { geo in
                let width = geo.size.width
                VStack {
                    ZStack(alignment: .center) {
                        Image("Squiggles")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width)
                        Image("ToothShine")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width * 0.6)
                    }
                    Text("开始刷牙!")
                        .font(.largeTitle.bold())
                        .padding(.bottom, 1)
                    Text("让我们一起刷动音律吧!")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.fontGray)
                    Spacer()
                    BrushIcon(
                        radius: 30,
                        color: .white,
                        opacity: 0.57
                    ).onTapGesture {
                        onStartWatch()
                    }
                    Image("StartTuneBrush").padding(.bottom, 50).padding(.top, 8)
                }
            }
        }.alert(msg, isPresented: $isPresented) {
            Button("OK") {
                isPresented = false
            }
        }
    }
    
    private func onStartWatch() {
        if !util.isPaired() {
            msg = "watch not paired"
            isPresented = true
            return
        }
        if !util.isWatchAppInstalled() {
            msg = "watch app not installed"
            isPresented = true
            return
        }
        util.startApp { success, _ in
            if success {
                var i = 0
                while (!util.isReachable() && i < 10) {
                    sleep(1)
                    util.send2Watch(["start": true], onSuccess: onStart)
                    i += 1
                }
                if i >= 10 {
                    msg = "watch not reachable"
                    isPresented = true
                }
            } else {
                msg = "start app failed"
                isPresented = true
            }
        }
    }
}

struct StartBrush_Previews: PreviewProvider {
    static var previews: some View {
        StartBrush {}
    }
}
