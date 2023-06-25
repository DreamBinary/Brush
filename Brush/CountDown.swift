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
    
    //    let timer = MyTimer()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
                Text("\(self.timeRemaining)")
                    .foregroundColor(Color(0x7DE2D1))
                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
            }.font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 160)
        }
        .onReceive(self.timer) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer.upstream.connect().cancel()
            }
        }
    }
}

// class MyTimer {
//    var timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
//    var cancellable: AnyCancellable?
//
//    func stop() {
//        self.cancellable?.cancel()
//    }
//
//    func start() {
//        self.cancellable = self.timer.connect() as? AnyCancellable
//    }
// }

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown()
    }
}
