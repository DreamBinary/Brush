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
            NoteView("Note0")
            NoteView("Note0")
            NoteView("Note0")
            NoteView("Note0")
            NoteView("Note1")
            NoteView("Note1")
            NoteView("Note1")
            NoteView("Note1")
        }.navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
    }
}

struct NoteView: View {
    var name: String
    
    @StateObject var noteObject = NoteObject(CGSize(width: 43, height: 40))
    @State var progress = 0
    
    var body: some View {
        Image(self.name)
            .resizable()
            .scaledToFit()
            .frame(width: 43, height: 40)
            .randomTransform(transform: self.noteObject.transform)
            .offset(x: noteObject.x, y: noteObject.y)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    withAnimation(.linear(duration: 0.01)) {
                        noteObject.move()
                    }
                }
            }
            .onChange(of: noteObject.x) { _ in
                noteObject.check()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

extension NoteView {
    init(_ name: String) {
        self.name = name
    }
}

class NoteObject: ObservableObject {
    var transform: TransformEntity = .init()
    private let maxWidth: Double
    private let maxHeight: Double
    private var dx: CGFloat
    private var dy: CGFloat
    
    @Published var x: CGFloat
    @Published var y: CGFloat
    
    private let maxX: Double
    private let maxY: Double
    
    private var cnt = 0
    
    init(_ imgSize: CGSize) {
        let maxSize = WKInterfaceDevice.current().screenBounds.size
        maxWidth = maxSize.width
        maxHeight = maxSize.height
        x = RandomUtil.rDouble() * maxWidth / 2
        y = RandomUtil.rDouble() * maxHeight / 2
        maxX = maxWidth / 2 + imgSize.width * transform.scale
        maxY = maxHeight / 2 + imgSize.height * transform.scale
        dx = RandomUtil.rDouble() * maxWidth / 5 / transform.scale / 100 // /100 for .linear(duration: 0.01) and .onChange(of: noteObject.x) -> (*** / 100) ensure *** in 1s and detect exactly
        dy = RandomUtil.rDouble() * maxHeight / 5 / transform.scale / 100 // / transform.scale for small->fast large->slow
    }
                
    func move() {
        x += dx
        y += dy
    }
        
    func check() {
        if x < -maxX {
            x = maxX
            cnt += 1
        }

        if x > maxX {
            x = -maxX
            cnt += 1
        }

        if y < -maxY {
            y = maxY
            cnt += 1
        }

        if y > maxY {
            y = -maxY
            cnt += 1
        }
        
        if cnt > 5 {
            reset()
            cnt = 0
        }
    }
    
    func reset() {
        transform = .init()
        dx = dx / abs(dx) * Double.random(in: 0 ... 1) * maxWidth / 5 / transform.scale / 100
        dy = dx / abs(dx) * Double.random(in: 0 ... 1) * maxHeight / 5 / transform.scale / 100
    }
}

struct TransformEntity {
    private static let unitPoints: [UnitPoint] = [.topLeading, .top, .topTrailing, .trailing, .bottomTrailing, .bottom, .bottomLeading, .leading]
    private static let colors: [Color] = [
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
    
    let scale: Double = .random(in: 0 ... 1) + 0.5
    
    let rAngle: Double = RandomUtil.rDouble() * 15
    
    let r3Angle: Double = RandomUtil.rDouble() * 15
    let r3x: Double = RandomUtil.rDouble()
    let r3y: Double = RandomUtil.rDouble()
    let r3z: Double = RandomUtil.rDouble()
    
    let selectPoints = RandomUtil.rSelect(data: unitPoints, num: 2)
    let selectColors = RandomUtil.rSelect(data: colors, num: 2)
}

extension View {
    func randomTransform(transform: TransformEntity) -> some View {
        return scaleEffect(transform.scale)
            .rotationEffect(.degrees(transform.rAngle))
            .rotation3DEffect(.degrees(transform.r3Angle), axis: (x: transform.r3x, y: transform.r3y, z: transform.r3z))
            .gradient(gradient: Gradient(colors: transform.selectColors), startPoint: transform.selectPoints[0], endPoint: transform.selectPoints[1])
    }
    
    func randomTransform() -> some View {
        return randomScale().randomRotaion().randomRotation3DEffect().randomGradient()
    }
    
    func randomRotaion() -> some View {
        let angle = RandomUtil.rDouble() * 15
        return rotationEffect(.degrees(angle))
    }
    
    func randomRotation3DEffect() -> some View {
        let angle = RandomUtil.rDouble() * 15
        let x = RandomUtil.rDouble()
        let y = RandomUtil.rDouble()
        let z = RandomUtil.rDouble()
        return rotation3DEffect(.degrees(angle), axis: (x: x, y: y, z: z))
    }
    
    func randomScale() -> some View {
        srand48(Int(time(nil)))
        let scale = drand48() + 0.8
        return scaleEffect(scale)
    }
    
    func randomGradient() -> some View {
        srand48(Int(time(nil)))
        let unitPoints: [UnitPoint] = [.topLeading, .top, .topTrailing, .trailing, .bottomTrailing, .bottom, .bottomLeading, .leading]
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
        
        return gradient(gradient: Gradient(colors: selectColors), startPoint: selectPoints[0], endPoint: selectPoints[1])
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
