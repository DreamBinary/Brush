//
//  ConnectEar.swift
//  Brush Watch App
//
//  Created by cxq on 2023/6/25.
//

import SwiftUI

struct ConnectEar: View {

    var body: some View {
        GeometryReader { geometry in
            BgView("ConnectEar") {
                VStack {
                    HStack {
                        Spacer()
                        Button {} label: {
                            Text("Cancel")
                        }
                        Spacer()
                        Button {} label: {
                            Text("Action")
                                .foregroundColor(Color(0x7DE2D1))
                        }
                        Spacer()
                    }.buttonStyle(.borderless)
                        .padding(.top, geometry.safeAreaInsets.top - 8)
                    Spacer()
                    Button {} label: {
                        Text("连接")
                            .padding(.bottom)
                    }
                }.edgesIgnoringSafeArea(.all)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
        }
        
    }
}

struct ConnectEar_Previews: PreviewProvider {
    static var previews: some View {
        ConnectEar()
    }
}
