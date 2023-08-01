//
//  CountDown.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import Combine
import SwiftUI

struct CountDown: View {
    @State private var timeRemaining = 5
    var cancellable: AnyCancellable?

    let timer = MyTimer()
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("CountDownBg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 5) {
                Text("准备好了吗？")
                Text("我们马上要开始啦！")
                Text("倒计时")
                    .padding(.top, 40)
                    .onTapGesture {
                        self.timeRemaining = 5
                        self.timer.restart()
                    }
                Text("\(self.timeRemaining)")
                    .foregroundColor(Color(0x7DE2D1))
                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                    .onTapGesture {
                        self.timer.start()
                    }
            }.font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 160)
        }
        .onReceive(self.timer.timer) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer.stop()
            }
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
