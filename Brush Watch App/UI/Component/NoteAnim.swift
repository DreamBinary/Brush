//
//  NoteAnim.swift
//  Brush Watch App
//
//  Created by cxq on 2023/7/21.
//

import SwiftUI

struct NoteAnim: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .top, endPoint: .bottom)
            
                .mask {
                    Image("Note0")
                }.rotationEffect(.degrees(15))
        }
    }
}

extension View {
    //    func randomTransform() -> some View {
    //        srand48(Int(time(nil)))
    ////        var temp:some View = self
    ////        if let a = Optional(drand48()), a < 0.5 {
    ////            let b = drand48()
    ////            let angle = a * (b < 0.5 ? 30 : -30)
    ////            temp = self.rotationEffect(.degrees(angle))
    ////        }
    //        self = self.rotationEffect(.degrees(1234))
    //        return self
    //    }
    
    func randomRotaion() -> some View {
        srand48(Int(time(nil)))
        let a = drand48()
        if a < 0.5 {
            let b = drand48()
            let angle = a * (b < 0.5 ? 30 : -30)
            return self.rotationEffect(.degrees(angle))
        } else {
            return self
        }
    }
    
//    func randomRotation3DEffect() -> some View {
//        srand48(Int(time(nil)))
//        if let a = Optional(drand48()), a < 0.5 {
//            let b = drand48()
//            let angle = a * (b < 0.5 ? 30 : -30)
//            return self.rotation3DEffect(.degrees(angle), axis: (x: angle, y: angle, z: angle))
//        } else {
//            return self
//        }
//    }
//
//    func randomOffset() -> some View {
//        srand48(Int(time(nil)))
//        if let a = Optional(drand48()), a < 0.5 {
//            let b = drand48()
//            let offset = a * (b < 0.5 ? 30 : -30)
//            return self.offset(x: offset, y: offset)
//        } else {
//            return self
//        }
//    }
//
//    func randomScale() -> some View {
//        srand48(Int(time(nil)))
//        if let a = Optional(drand48()), a < 0.5 {
//            let scale = a * 2 + 0.5
//            return self.scaleEffect(scale)
//        } else {
//            return self
//        }
//    }
//
//    func randomBlur() -> some View {
//        srand48(Int(time(nil)))
//        if let a = Optional(drand48()), a < 0.5 {
//            let b = drand48()
//            let blur = a * (b < 0.5 ? 10 : -10)
//            return self.blur(radius: blur)
//        } else {
//            return self
//        }
//    }
//
//
//    func randomColor() -> some View {
//        srand48(Int(time(nil)))
//        if let a = Optional(drand48()), a < 0.5 {
//            let b = drand48()
//            let color = a * (b < 0.5 ? 10 : -10)
//            return self.colorMultiply(Color(red: color, green: color, blue: color))
//        } else {
//            return self
//        }
//    }
//
//    func randomGradient() -> some View {
//        srand48(Int(time(nil)))
//        if let a = Optional(drand48()), a < 0.5 {
//            let b = drand48()
//            let color = a * (b < 0.5 ? 10 : -10)
//            return self.colorMultiply(Color(red: color, green: color, blue: color))
//        } else {
//            return self
//        }
//    }
    
    
    
    
    
    
    
}

extension Image {
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
