//
//  NewLogin.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/7/23.
//

import SwiftUI
import ComposableArchitecture

//文字展示组件
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


struct LoginView: View {
    
    let store: StoreOf<Login>
    
    // 是否展示登录状态字段
    @State private var loginViewActive = false
    // 紫色卡片的状态
    @State private var purpleToothCurrent=PurpleToothSatus()
    let purpleToothFirst=PurpleToothSatus(x: 0, y: 0)
    let purpleToothSecond=PurpleToothSatus(x: 0, y: 50)
    let purpleToothThird=PurpleToothSatus(x: 0, y: 50,color:Color(0xA9FDC1),image:Image("ToothGum"),angle:30)
    
    // tunebrushLogo状态
    @State private var tuneBrushBtnCurrent=TuneBrushBtnStatus()
    let tuneBrushBtnWhite=TuneBrushBtnStatus()
    let tuneBrushBtnPurple=TuneBrushBtnStatus(bgColor:Color(0xADC4FF),radius:40,opacity:0.65)
    let tuneBrushBtnGreen=TuneBrushBtnStatus(bgColor:Color(0xBEFFD0),radius:40,opacity:0.81)
    
    //动画命名空间
    @Namespace var animation
    
    struct PurpleToothSatus {
        var x: Double=0
        var y: Double=0
        var color:Color=Color(0xA9C1FD)
        var image:Image=Image("ToothShine")
        var angle:Double = -20
    }
    struct TuneBrushBtnStatus{
        var bgColor:Color = .white
        var radius:Double = 30
        var opacity:Double = 0.57
    }
    
    
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            BgView("Login"){
                ZStack{
                    // Z第一层
                    VStack{
                        Spacer()
                        // 顶部两个图标
                        HStack {
                            SquareIconView(iconImage: Image("ToothGum"), color: Color(0xA9FDC1), sideLength: 140)
                                .rotationEffect(Angle(degrees: 30))
                                .offset(x: !loginViewActive ? -20 : -UIScreen.main.bounds.width)
                                .animation(.easeInOut(duration: 0.5), value: loginViewActive)
                            Spacer()
                        }
                        
                        //文字
                        VStack(spacing: 0){
                            TextDisplayView(text: "Let's", fontSize: 80, textColor: .white)
                            Image("BrushText").frame(width: UIScreen.main.bounds.width, alignment: .bottomLeading)
                            TextDisplayView(text: "With", fontSize: 80, textColor: .white)
                            Image("MusicText").frame(width: UIScreen.main.bounds.width, alignment: .bottomLeading)
                        }.padding(.leading, 20)
                            .offset(x: !loginViewActive ? 0 : -UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.5), value: loginViewActive)
                        Spacer()
                        
                        VStack{
                            BrushIcon(color:.white.opacity(0.57))
                            Image("StartTuneBrush").padding(.bottom,50)
                        }.hidden()
                    }
                    
                    // Z第二层
                    VStack{
                        HStack{
                            if !loginViewActive{
                                Spacer()
                            }
                            SquareIconView(iconImage: purpleToothCurrent.image, color:purpleToothCurrent.color, sideLength: 200)
                                .rotationEffect(Angle(degrees: purpleToothCurrent.angle))
                                .offset(x: purpleToothCurrent.x,y:purpleToothCurrent.y)
                                .animation(.spring(), value: loginViewActive)
                                .padding(.top,UIScreen.main.bounds.height*0.1)
                        }
                        Spacer()
                    }
                    
                    // Z第三层
                    
                    if loginViewActive{
                        VStack{
                            Spacer()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.5)
                                .background(Color(red: 0.99, green: 0.99, blue: 0.99))
                                .cornerRadius(16).overlay(
                                    VStack(){
                                        VStack(alignment: .leading, spacing: 12) {
                                            Spacer()
                                            
                                            Text(vStore.isLogin
                                                 ? "Hi There,\nWelcome back!"
                                                 : "Hi There,\nHave an account!"
                                            ).font(.system(size: 32)) // 使用自定义字体和字体大小
                                                .fontWeight(.bold) // 设置字体粗细
                                                .padding(.bottom,10)
                                            EnterInputView(
                                                store: store.scope(state: \.enterInput, action: Login.Action.enterInput),
                                                signUpButtonAction: { parameter in
                                                    // 在这里处理点击 "Sign Up" 的逻辑
                                                    withAnimation(.easeInOut(duration: 0.5 )) {
                                                        if parameter == EnterInput.InputType.Login{
                                                            purpleToothCurrent=purpleToothSecond
                                                            tuneBrushBtnCurrent=tuneBrushBtnPurple
                                                            print("现在是登录")
                                                        }else{
                                                            purpleToothCurrent=purpleToothThird
                                                            tuneBrushBtnCurrent=tuneBrushBtnGreen
                                                            print("现在是注册")
                                                        }
                                                    }
                                                    
                                                }
                                            )
                                            EnterWay().padding(.vertical, 10)
                                            Spacer()
                                        }.frame(width: UIScreen.main.bounds.width*0.7)
                                        Spacer()
                                    }
                                )
                        }.transition(.move(edge: .bottom)).animation(.easeInOut(duration: 0.5), value: loginViewActive)
                    }
                    
                    // Z第四层
                    VStack{
                        if !loginViewActive{
                            Spacer()
                        }
                        BrushIcon(radius: tuneBrushBtnCurrent.radius,
                                  color:tuneBrushBtnCurrent.bgColor,
                                  opacity:tuneBrushBtnCurrent.opacity).onTapGesture {
                            print("展示登录页面")
                            withAnimation(.easeInOut(duration: 0.5 )) {
                                loginViewActive.toggle()
                                if loginViewActive{
                                    if vStore.isLogin{
                                        purpleToothCurrent=purpleToothSecond
                                        tuneBrushBtnCurrent=tuneBrushBtnPurple
                                    }else {
                                        purpleToothCurrent=purpleToothThird
                                        tuneBrushBtnCurrent=tuneBrushBtnGreen
                                    }

                                }else{
                                    purpleToothCurrent=purpleToothFirst
                                    tuneBrushBtnCurrent=tuneBrushBtnWhite
                                }
                            }

                        }
                        if !loginViewActive{
                            Image("StartTuneBrush").padding(.bottom,50)
                        }
                        
                    }
                    
                }
            }
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
        var enterInput = EnterInput.State()
    }

    enum Action: BindableAction, Equatable {
        case enterInput(EnterInput.Action)
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
                    withAnimation(.interactiveSpring()) {
                        state.isLogin.toggle()
                    }
                    return .none
                case .enterInput, .binding:
                    return .none
            }
        }
    }
}
