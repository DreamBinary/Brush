//
//  MyTabBar.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

struct MyTabBar: View {
    let unSeletedImages = [
        "analysis0", "", "mine0"
    ]
    let seletedImages = [
        "analysis1", "", "mine1"
    ]
    static var height: CGFloat = 60
    var width: CGFloat = UIScreen.main.bounds.width * 0.6
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            Spacer()
            ForEach(0 ..< 3) { index in
                Button {
                    withAnimation(.interactiveSpring()) {
                        self.selectedIndex = index
                    }
                } label: {
                    if index == 1 {
                        BrushIcon(radius: MyTabBar.height * 0.45)
                    } else {
                        Image(selectedIndex == index ? seletedImages[index] : unSeletedImages[index])
                    }
                }
                Spacer()
            }
        }
        .frame(width: width, height: MyTabBar.height)
        .background(Color(0x99C7C2, 0.38))
        .clipShape(RoundedCorners(corners: [.allCorners], radius: MyTabBar.height / 2))
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct MyTabBar_Previews: PreviewProvider {
    static var previews: some View {
        @State var index = 1
        MyTabBar(selectedIndex: $index)
    }
}
