//
//  CountDown.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import Combine
import SwiftUI

struct CountDown: View {
    var onEnd: () -> Void
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
                            CountDownNum(onEnd: onEnd)

                        }.font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, height * 0.4)
                    }
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
                    AnimViolin().frame(width: width * 0.65, height: width * 0.5)
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

struct CountDownNum: View {
    var onEnd: () -> Void
    @State private var cnt = 3
    @State private var scale: Double = 1
    private let font: Font = .system(size: UIFont.textStyleSize(.largeTitle) * 1.5).bold()
    private let timer = MyTimer()
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
                                .foregroundColor(Color(0x7DE2D1))
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
                print("appear")
                self.textScale()
                self.timer.start()
            }
            .onReceive(self.timer.timer) { _ in
                if self.cnt > 0 {
                    withAnimation(.interactiveSpring()) {
                        let _ = print("fasd")
                        self.cnt -= 1
                    }
                    self.textScale()
                } else {
                    self.timer.stop()
                    self.onEnd()
                }
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
        CountDown(){}
    }
}
