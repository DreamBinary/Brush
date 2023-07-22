//
//  NoteAnim.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/21.
//

import SwiftUI

struct NoteAnim: View {
    @State var dx: CGFloat = 0
    @State var dy: CGFloat = 0
  
    var body: some View {
        VStack {
            // Note0 container
            VStack {
                Image("Note0").randomTransform()
                    .offset(x: dx, y: dy)
                    .onTapGesture {
                        dx += 2
                        
                        
                        dy += 2
                    }
            }
            // Note1 container
            VStack {
                Image("Note1").randomTransform()
            }
        }
    }
}



extension View {
    func randomTransform() -> some View {
        return self.randomScale().randomRotaion().randomRotation3DEffect().randomGradient()
    }
    
    func randomRotaion() -> some View {
        let angle = RandomUtil.rDouble() * 15
        return self.rotationEffect(.degrees(angle))
    }
    
    func randomRotation3DEffect() -> some View {
        let angle = RandomUtil.rDouble() * 15
        let x = RandomUtil.rDouble()
        let y = RandomUtil.rDouble()
        let z = RandomUtil.rDouble()
        return self.rotation3DEffect(.degrees(angle), axis: (x: x, y: y, z: z))
    }
    
    func randomScale() -> some View {
        srand48(Int(time(nil)))
        let scale = drand48() + 0.8
        return self.scaleEffect(scale)
    }
    
    func randomGradient() -> some View {
        srand48(Int(time(nil)))
        let unitPoints: [UnitPoint] = [.topLeading, .top, .topTrailing, .trailing, .bottomTrailing, .bottom, .bottomLeading, .leading,]
        let colors: [Color] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple,
            .pink,
            .secondary,
            .accentColor,
            .gray,
        ]
        
        
        let selectPoints = RandomUtil.rSelect(data: unitPoints, num: 2)
        let selectColors = RandomUtil.rSelect(data: colors, num: 2)
        
        return self.gradient(gradient: Gradient(colors: selectColors), startPoint: selectPoints[0], endPoint: selectPoints[1])
    }
}

extension View {
    func gradient(gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        return LinearGradient(
            gradient: gradient,
            startPoint: startPoint,
            endPoint: endPoint
        ).mask(self)
    }
}

struct NoteAnim_Previews: PreviewProvider {
    static var previews: some View {
        BgColor(.white) {
            NoteAnim()
        }
    }
}
