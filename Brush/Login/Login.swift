//
//  NewLogin.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/7/23.
//

import ComposableArchitecture
import SwiftUI

// 文字展示组件
struct TextDisplayView: View {
    var text: String
    var fontSize: CGFloat
    var textColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .heavy))
            .italic()
            .foregroundColor(textColor)
            .frame(width: UIScreen.main.bounds.width, alignment: .bottomLeading)
    }
}

// class PurpleToothSatus: ObservableObject {
//    @Published var y: Double = 0
//    @Published var color: Color = .init(0xADC4FF)
//    @Published var angle: Double = 30
//    let image: Image = .init("ToothGum")
//    func toFirst() {
//        y = 0
//    }
//
//    func toSecond() {
//        y = 50
//    }
//
//    func toThird() {
//        y = 50
//        color = Color(0xA9FDC1)
//        angle = 30
//    }
// }
//
// class TuneBrushBtnStatus: ObservableObject {
//    @Published var bgColor: Color = .white
//    @Published var radius: Double = 30
//    @Published var opacity: Double = 0.57
//    func toWhite() {
//        bgColor = .white
//        radius = 30
//        opacity = 0.57
//    }
//
//    func toPurple() {
//        bgColor = Color(0xADC4FF)
//        radius = 40
//        opacity = 0.65
//    }
//
//    func toGreen() {
//        bgColor = Color(0xBEFFD0)
//        radius = 40
//        opacity = 0.81
//    }
// }

class PurpleToothStatus: Equatable {
    static func == (lhs: PurpleToothStatus, rhs: PurpleToothStatus) -> Bool {
        lhs.y == rhs.y && lhs.color == rhs.color && lhs.angle == rhs.angle
    }
    
    var y: Double = 0
    var color: Color = .init(0xADC4FF)
    var angle: Double = 30
    let image: Image = .init("ToothGum")
    func toFirst() {
        y = 0
        color = .init(0xADC4FF)
        angle = -20
    }
    
    func toSecond() {
        y = 50
        color = .init(0xADC4FF)
        angle = -20
    }
    
    func toThird() {
        y = 50
        color = Color(0xA9FDC1)
        angle = 30
    }
}

struct LoginView: View {
    let store: StoreOf<Login>
    
    // 是否展示登录状态字段
    //    @State private var loginViewActive = false
    // 紫色卡片的状态
    //    @StateObject private var purpleToothVm = PurpleToothSatus()
    //    let purpleToothFirst=PurpleToothSatus(x: 0, y: 0)
    //    let purpleToothSecond=PurpleToothSatus(x: 0, y: 50)
    //    let purpleToothThird=PurpleToothSatus(x: 0, y: 50, color: Color(0xA9FDC1), image: Image("ToothGum"), angle: 30)
    
    // tunebrushLogo状态
    //    @StateObject private var brushBtnVm = TuneBrushBtnStatus()
    //    let tuneBrushBtnWhite=TuneBrushBtnStatus()
    //    let tuneBrushBtnPurple=TuneBrushBtnStatus(bgColor: Color(0xADC4FF), radius: 40, opacity: 0.65)
    //    let tuneBrushBtnGreen=TuneBrushBtnStatus(bgColor: Color(0xBEFFD0), radius: 40, opacity: 0.81)
    
    // 动画命名空间
    //    @Namespace var animation
    
    //    struct PurpleToothSatus {
    //        var x: Double=0
    //        var y: Double=0
    //        var color: Color = .init(0xA9C1FD)
    //        var image: Image = .init("ToothShine")
    //        var angle: Double = -20
    //    }
    
    //    struct TuneBrushBtnStatus {
    //        var bgColor: Color = .white
    //        var radius: Double=30
    //        var opacity: Double=0.57
    //    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            BgColor {
                ZStack {
                    // Z第一层
                    FirstView(isRemove: vStore.isLoginView)
                    
                    // Z第二层
                    VStack {
                        HStack {
                            if !vStore.isLoginView {
                                Spacer()
                            }
                            SquareIconView(iconImage: vStore.purpleToothVm.image, color: vStore.purpleToothVm.color, sideLength: 200, degrees: vStore.purpleToothVm.angle)
                                .offset(y: vStore.purpleToothVm.y)
                                .padding(.top, screenHeight * 0.1)
                        }
                        Spacer()
                    }.onTapGesture {
                        vStore.send(.enterInput(.changeType))
                    }
                    
                    // Z第三层
                    VStack {
                        Spacer()
                        Card(color: Color(red: 0.99, green: 0.99, blue: 0.99), cornerRadius: 15) {
                            VStack(alignment: .leading, spacing: 12) {
                                Spacer()
                                Group {
                                    if vStore.isLogin {
                                        Text("Hi There,\nWelcome back!")
                                    } else {
                                        Text("Hi There,\nHave an account!")
                                    }
                                }.font(.system(size: 32)) // 使用自定义字体和字体大小
                                    .fontWeight(.bold) // 设置字体粗细
                                    .padding(.bottom, 10)
                                EnterInputView(
                                    store: store.scope(state: \.enterInput, action: Login.Action.enterInput)
                                )
                                EnterWay().padding(.vertical, 10)
                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width * 0.7)
                        }.frame(width: screenWidth, height: screenHeight * 0.5)
                            .offset(y: vStore.isLoginView ? 0 : screenHeight)
                    }
                    
                    // Z第四层
                    VStack {
                        if !vStore.isLoginView {
                            Spacer()
                        }
                        BrushIcon(
                            radius: vStore.brushBtnVm.radius,
                            color: vStore.brushBtnVm.bgColor,
                            opacity: vStore.brushBtnVm.opacity
                        ).onTapGesture {
                            vStore.send(.onBrushBtnTapped)
                        }
                        if !vStore.isLoginView {
                            Image("StartTuneBrush").padding(.bottom, 50).padding(.top)
                        }
                    }
                }
            }.animation(.easeInOut(duration: 0.5), value: vStore.isLoginView)
                .animation(.easeInOut(duration: 0.5), value: vStore.isLogin)
        }
    }
}

struct FirstView: View {
    var isRemove: Bool
    
    var body: some View {
        VStack {
            Spacer()
            // 顶部两个图标
            HStack {
                SquareIconView(iconImage: Image("ToothGum"), color: Color(0xA9FDC1), sideLength: 140, degrees: 30)
                    .offset(x: isRemove ? -screenWidth : -20)
                Spacer()
            }
            // 文字
            ImgText()
                .padding(.leading, 20)
                .offset(x: isRemove ? -screenWidth : 0)
            
            Spacer()
        }
    }
}

struct ImgText: View {
    var body: some View {
        VStack(spacing: 0) {
            TextDisplayView(text: "Let's", fontSize: 80, textColor: .white)
            Image("BrushText")
                .frame(width: screenWidth, alignment: .bottomLeading)
            TextDisplayView(text: "With", fontSize: 80, textColor: .white)
            Image("MusicText").frame(width: screenWidth, alignment: .bottomLeading)
        }
    }
}

struct NewLogin_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: Login.State(),
                reducer: Login()
            )
        )
    }
}

struct Login: ReducerProtocol {
    struct State: Equatable {
        var isLogin = true
        var isLoginView = false
        var enterInput = EnterInput.State()
        var brushBtnVm = BrushBtnStatus()
        var purpleToothVm = PurpleToothStatus()
    }
    
    enum Action: BindableAction, Equatable {
        case enterInput(EnterInput.Action)
        case onBrushBtnTapped
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.enterInput, action: /Action.enterInput) {
            EnterInput()
        }
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .enterInput(.changeType):
                    state.isLogin.toggle()
                    if state.isLogin {
                        state.purpleToothVm.toSecond()
                        state.brushBtnVm.change(to: .purple)
                    } else {
                        state.purpleToothVm.toThird()
                        state.brushBtnVm.change(to: .green)
                    }
                    
                    return .none
                case .onBrushBtnTapped:
                    state.isLoginView.toggle()
                    if state.isLoginView {
                        if state.isLogin {
                            state.purpleToothVm.toSecond()
                            state.brushBtnVm.change(to: .purple)
                        } else {
                            state.purpleToothVm.toThird()
                            state.brushBtnVm.change(to: .green)
                        }
                    } else {
                        state.purpleToothVm.toFirst()
                        state.brushBtnVm.change(to: .white)
                    }
                    return .none
                case .enterInput, .binding:
                    return .none
            }
        }
    }
}
