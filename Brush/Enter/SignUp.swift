//
//  SignUp.swift
//  Brush
//
//  Created by cxq on 2023/6/22.
//

import SwiftUI

struct SignUp: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("SignUp")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Button {
                print("")
            } label: {
                Image("bottom20")
                    .shadow(color: Color(0x000000, 0.25), radius: 10, x: 5, y: 10)
                    .padding(.bottom, 110)
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
