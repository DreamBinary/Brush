////
////  BrushingFinished.swift
////  Brush
////
////  Created by cxq on 2023/6/23.
////
//
//import SwiftUI
//
//struct FinishBrush: View {
//    var body: some View {
//        BgColor {
//            GeometryReader { geo in
//                let width = geo.size.width
//                VStack {
//                    ZStack(alignment: .center) {
//                        Image("Squiggles")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: width)
//                        Image("ToothShine")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: width * 0.6)
//                    }
//                    
//                    Text("恭喜您！")
//                        .font(.largeTitle.bold())
//                        .padding(.bottom, 1)
//                    Text("您的牙齿很健康")
//                        .font(.body)
//                        .fontWeight(.regular)
//                        .foregroundColor(.fontGray)
//                    Spacer()
//                    BrushIcon(
//                        radius: 30,
//                        color: .white,
//                        opacity: 0.57
//                    ).onTapGesture {
//                        
//                    }
//                    Image("StartTuneBrush").padding(.bottom, 50).padding(.top, 8)
//                }
//            }
//        }
////        BgView("BrushingFinished") {
//            VStack(spacing: 2) {
//                Text("恭喜您！")
//                Text("您的牙齿很健康")
//                Text("记得好好保持哦")
//                    .font(.title3)
//                    .foregroundColor(.fontGray)
//                    .fontWeight(.regular)
//                
//                BrushIcon()
//                    .padding(.top, 120)
//                    
//            }.font(.largeTitle)
//                .fontWeight(.bold)
//                .padding(.top, 300)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Image("BrushingFinished"))
//                .edgesIgnoringSafeArea(.all)
//        
//    }
//}
//
//struct BrushingFinished_Previews: PreviewProvider {
//    static var previews: some View {
//        FinishBrush()
//    }
//}
