//
//  CountDown.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

struct CountDown: View {
    @State private var timeRemaining = 5
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
                Text("\(timeRemaining)")
                    .foregroundColor(Color(0x7DE2D1))
                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
            }.font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 160)
        }
        .onReceive(timer) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
    }
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown()
    }
}
