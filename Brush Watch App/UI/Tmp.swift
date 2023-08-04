//
//  Tmp.swift
//  Brush Watch App
//
//  Created by cxq on 2023/8/3.
//

import SwiftUI
import AVFoundation

struct Tmp: View {
    @State var x: Double = 0
    @State var y: Double = 0
    @State var z: Double = 0
    let util = MotionUtil()
    let player = MusicUtil(res: "bgm")
    @State var isStart = false
    var body: some View {
        let path: String = Logger.path ?? "none"
        
        VStack {
            Text("\(path)")
            Text("\(x)")
            Text("\(y)")
            Text("\(z)")
        }.foregroundColor(.black)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .onTapGesture {
                isStart.toggle()
                
                if (isStart) {
                    player.play()
                    Logger.config()
                    Logger.logi("View appeared") // 保存调试信息到文件
                    //                Timer.scheduledTimer(withTimeInterval: 1 / 50, repeats: true) { _ in
                    util.startAccelerometers { xx, yy, zz in
                        x = xx
                        y = yy
                        z = zz
                        Logger.logi("x: \(x), y: \(y), z: \(z)")
                    }
                } else {
                    player.stop()
                    util.stopAccelerometers()
                    Logger.logi("View disappeared") // 保存调试信息到文件
                }
            }
    }
}

//struct Tmp_Previews: PreviewProvider {
//    static var previews: some View {
//        Tmp(x)
//    }
//}
