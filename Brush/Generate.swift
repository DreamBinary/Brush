//
//  Generate.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct Generate: View {
    var body: some View {
        BgView("GenerateBg") {
            VoiceAnimation()
                .offset(y: 260)
        }
    }
}

struct Generate_Previews: PreviewProvider {
    static var previews: some View {
        Generate()
    }
}
