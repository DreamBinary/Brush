//
//  Start.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

struct Start: View {
    var onStart: () -> Void
    var body: some View {
        BgColor(.primary) {
            ZStack {
                AnimViolin()
                
                AnimNote()
                
               
                
//                Image("StartBg")
//                    .resizable()
//                    .scaledToFit()

                Text("Start!")
                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.4))
                    .fontWeight(.bold)
                    .onTapGesture {
                        onStart()
                    }
            }
        }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start(){}
    }
}
