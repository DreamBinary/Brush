//
//  CountDown.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/31.
//


import SwiftUI

struct CountDown: View {
    @Binding var cnt: Int
    var onEnd: () -> Void
    @State private var scale: Double = 1

    private let font: Font = .system(size: UIFont.textStyleSize(.largeTitle) * 1.5).bold()
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
                                .foregroundColor(.white)
                                .font(self.font)
                                .frame(width: width, height: height, alignment: .center)
                        }
                    }
                    .offset(y: -height * CGFloat(self.cnt))
                }
            }
            .clipped()
            .onAppear {
                self.textScale()
            }
            .onChange(of: self.cnt) { _ in
                if self.cnt > 0 {
                    self.textScale()
                } else {
                    self.onEnd()
                }
            }
    }

    func textScale() {
        withAnimation(.easeIn(duration: 0.2)) {
            self.scale = 1.5
        }
        withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
            self.scale = 1.0
        }
    }
}




