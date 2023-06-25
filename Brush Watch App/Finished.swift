//
//  Finished.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct Finished: View {
    var body: some View {
        BgView("Finished") {
            VStack {
                Spacer()

                Button {} label: {
                    Text("OK")
                        .font(.title3)
                        .fontWeight(.medium)
                        .underline(pattern: .solid)
                        .foregroundColor(.fontBlack)
                        .padding(.bottom)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Finished_Previews: PreviewProvider {
    static var previews: some View {
        Finished()
    }
}
