//
//  Finished.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct Finish: View {
    var onFinished: () -> Void

    var body: some View {
//        BgView("Finished") {
//            VStack {
//                Spacer()
//
//                Button {} label: {
//                    Text("OK")
//                        .font(.title3)
//                        .fontWeight(.medium)
//                        .underline(pattern: .solid)
//                        .foregroundColor(.fontBlack)
//                        .padding(.bottom)
//                }
//            }
//            .edgesIgnoringSafeArea(.bottom)
//        }
        BgColor(.primary) {
            VStack {
                Spacer()
                Image("Finished")
                    .resizable()
                    .scaledToFit()
                Text("您已完成今日份口腔清洁！")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.fontBlack)
                    .padding(.top)
                Text("要好好保持哦！")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Button {
                    onFinished()
                } label: {
                    Text("OK")
                        .font(.title3)
                        .fontWeight(.medium)
                        .underline(pattern: .solid)
                        .foregroundColor(.fontBlack)
                }
            }.padding(.bottom)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Finished_Previews: PreviewProvider {
    static var previews: some View {
        Finish() {
            
        }
    }
}
