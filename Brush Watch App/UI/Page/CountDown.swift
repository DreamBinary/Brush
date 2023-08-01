//
//  CountDown.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/31.
//

import Combine
import SwiftUI

struct CountDown: View {
    var onEnd: () -> Void

    @State var cnt = 3
    @State var scale: Double = 1
    let timer = MyTimer()
    let font: Font = .system(size: UIFont.textStyleSize(.largeTitle) * 1.5).bold()
    var body: some View {
        Text("0")
            .font(self.font)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .opacity(0)
            .overlay {
                GeometryReader { geo in
                    let width = geo.size.width
                    let height = geo.size.height
                    VStack(alignment: .center, spacing: 0) {
                        ForEach(0 ... 3, id: \.self) { i in
                            Text("\(i)")
                                .scaleEffect(self.scale)
                                .foregroundColor(.white)
                                .font(self.font)
                                .frame(width: width, height: height, alignment: .center)
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: -height * CGFloat(self.cnt))
                }
            }
            .clipped()
            .onAppear {
                self.textScale()
                self.timer.start()
            }
            .onReceive(self.timer.timer) { _ in
                if self.cnt > 0 {
                    withAnimation(.interactiveSpring()) {
                        if self.cnt > 0 {
                            self.cnt -= 1
                        } else {
                            self.cnt = 3
                        }
                    }
                    self.textScale()
                } else {
                    self.timer.stop()
                    self.onEnd()
                }
            }
            .onTapGesture {
                self.cnt = 3
            }
    }

    func textScale() {
        withAnimation(.easeIn(duration: 0.2)) {
            self.scale = 1.5
        }
        withAnimation(.easeOut(duration: 0.8).delay(0.5)) {
            self.scale = 1.0
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
        CountDown(onEnd: {})
    }
}