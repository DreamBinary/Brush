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
    @State private var hasBeat: Bool = true
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
                    
                    HStack(spacing: 2) {
                        Text("节拍器").font(.footnote)
                        Image(systemName: hasBeat ? "checkmark.circle" :"circle").resizable().frame(width: 12, height: 12)
                    }.onTapGesture {
                        hasBeat.toggle()
                    }.foregroundColor(.fontGray)
                    
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
            msg = "还没有连接上你的 Apple Watch 吧"
            isPresented = true
            return
        }
        if !util.isWatchAppInstalled() {
            msg = "是不是还没安装我们的 TuneBrush Watch"
            isPresented = true
            return
        }
        
        util.startApp { success, _ in
            if success {
                if !util.isReachable() {
                    msg = "信号发送出了错,再试试或者手动打开吧"
                    isPresented = true
                    util.activate()
                    return
                }
            } else {
                msg = "TuneBrush Watch 打开失败了,再试试或者手动打开吧"
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
