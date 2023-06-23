//
//  Generate.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct Generate: View {
    var body: some View {
        Image("GenerateBg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

struct Generate_Previews: PreviewProvider {
    static var previews: some View {
        Generate()
    }
}
