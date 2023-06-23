//
//  Rating.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

struct Rating: View {
    
    @State var score = 0
    var body: some View {
        
        HStack {
            ForEach(1..<6) { index in
                Button {
                    withAnimation(.interactiveSpring()) {
                        score = index
                    }
                } label: {
                    Image(index <= score ? "ToothRatingFill" : "ToothRating")
                }
            }
        }
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating()
    }
}
