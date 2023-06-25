//
//  BgView.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

import SwiftUI

struct BgView<Content>: View where Content: View {
    var name: String
    var content: () -> Content
    
    var body: some View {
        content()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Image(name)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
    }
}

extension BgView {
    init(_ name: String, @ViewBuilder _ content: @escaping () -> Content) {
        self.name = name
        self.content = content
    }
}

struct BgView_Previews: PreviewProvider {
    static var previews: some View {
        BgView(name: "StartBg") {
            Text("Hello")
        }
    }
}
