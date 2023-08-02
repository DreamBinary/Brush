//
//  CountDown.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import Combine
import SwiftUI

struct CountDown: View {
    @State private var cnt = 3
    var cancellable: AnyCancellable?

    let timer = MyTimer()
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        BgView("CountDownBg") {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                ZStack {
                    CountDownBg()
                    
                    
                                VStack(spacing: 5) {
                                    Text("准备好了吗？")
                                    Text("我们马上要开始啦！")
                                    HStack {
                                        Spacer()
                                        Image("DrawLine")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: width / 2)
                                            .padding(.trailing)
                                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                    }
                                    Text("倒计时")
                                        .padding(.top, 40)
                                    Text("\(self.cnt)")
                                        .foregroundColor(Color(0x7DE2D1))
                                        .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                        .onTapGesture {
                                            self.timer.start()
                                        }
                                }.font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.top, height * 0.4)
                }
                
            }
        }
        .onAppear {
            timer.start()
        }
        .onReceive(self.timer.timer) { _ in
            if self.cnt > 0 {
                self.cnt -= 1
            } else {
                self.timer.stop()
            }
        }
    }
}

struct CountDownBg: View {
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            VStack(spacing: 0) {
                ZStack {
                    Image("CountDownBgTop")
                        .resizable()
                        .scaledToFit().frame(width: width)
                    AnimViolin().frame(width: width * 0.65, height:  width * 0.5)
                }.padding(.top)
                
                Spacer()
                Image("CountDownBgBottom")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

class MyTimer {
    var interval = 1.0
    var timer: Timer.TimerPublisher
    var cancellable: AnyCancellable?

    init(interval: Double = 1.0) {
        self.interval = interval
        self.timer = Timer.TimerPublisher(interval: interval, runLoop: .main, mode: .default)
    }

    func restart() {
        self.timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
        self.cancellable = self.timer.connect() as? AnyCancellable
    }

    func stop() {
        self.cancellable?.cancel()
    }

    func start() {
        self.cancellable = self.timer.connect() as? AnyCancellable
    }
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown()
    }
}
