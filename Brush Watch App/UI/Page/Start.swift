//
//  Start.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct Start: View {
    var body: some View {
        BgColor(.primary) {
            ZStack {
                VStack(spacing: 0) {
                    Image("StartBg")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    Text("外左下片区")
                        .font(.title2)
                        .fontWeight(.bold)
                }.padding(.bottom)
                    .edgesIgnoringSafeArea(.bottom)
                Text("Start!")
                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.4))
                    .fontWeight(.bold)
            }
        }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
