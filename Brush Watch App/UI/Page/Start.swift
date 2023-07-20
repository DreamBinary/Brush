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
//                    VStack(spacing: 0) {
//                        Image("StartBg")
//                            .resizable()
//                            .scaledToFit()
//                        Spacer()
////                        Text(SectionUtil.getName(cSection.section))
////                            .font(.title2)
////                            .fontWeight(.bold)
//                    }.padding(.bottom)
//                        .edgesIgnoringSafeArea(.bottom)
                    Image("StartBg")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Start!")
                        .font(.system(size: UIFont.textStyleSize(.largeTitle) * 1.4))
                        .fontWeight(.bold)
//                    NavigationLink(destination: SectionPre(.OLB), isActive: $isActive) {
//                        EmptyView()
//                    }.hidden()
                        
                }
            }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
