//
//  MyTabBar.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

struct MyTabBar: View {
    let unSeletedImages = [
        "bottom00", "bottom10", "bottom20", "bottom30", "bottom40"
    ]
    let seletedImages = [
        "bottom01", "bottom11", "bottom20", "bottom31", "bottom41"
    ]
    var height: CGFloat = 70
    var width: CGFloat = UIScreen.main.bounds.width
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            Spacer()
            ForEach(0 ..< 5) { index in
                Button {
                    withAnimation(.interactiveSpring()) {
                        self.selectedIndex = index
                    }
                } label: {
                    if index == 2 {
                        Image(unSeletedImages[index])
                            .shadow(color: Color(0x000000, alpha: 0.25), radius: 10, x: 5, y: 10)
                    } else {
                        Image(selectedIndex == index ? seletedImages[index] : unSeletedImages[index])
                    }
                }
                Spacer()
            }
        }
        .frame(width: width, height: height)
        .background(.ultraThinMaterial)
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
