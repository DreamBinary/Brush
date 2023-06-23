//
//  Mine.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Mine: ReducerProtocol {
    struct State: Equatable {
//        @BindingState var
        var name: String = ""
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { _, action in
            switch action {
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct MineView: View {
    let store: StoreOf<Mine>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            
            BgView("MineBg") {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: 204, height: 204)
                            .foregroundColor(Color(0xA9C1FD))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0), radius: 14.5, x: 48, y: -93)
                            .shadow(color: .black.opacity(0.01), radius: 13.5, x: 31, y: -59)
                            .shadow(color: .black.opacity(0.05), radius: 11.5, x: 17, y: -33)
                            .shadow(color: .black.opacity(0.09), radius: 8.5, x: 8, y: -15)
                            .shadow(color: .black.opacity(0.1), radius: 4.5, x: 2, y: -4)
                            .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
                            .rotationEffect(Angle(degrees: -13.99))
                        Avatar(radius: 150, fillColor: Color(0xB5EEC4))
                    }.padding(.top, 50)
                        .padding(.bottom)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 5) {
                            Text("Conan Worsh")
                                .font(.largeTitle.bold())
                            
                            Text("I want BRIGHT smile")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.fontGray)
                            
                            HStack(alignment: .firstTextBaseline) {
                                Text("136")
                                    .font(.largeTitle.bold())
                                Text("天")
                                    .font(.callout)
                                    .foregroundColor(.fontGray)
                            }.padding(.top, 25)
                            
                            Text("加入 TuneBrush")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.fontGray)
                            
                            HStack(spacing: 15) {
                                Button {} label: {
                                    Card(color: Color(0xA9C1FD)) {
                                        ZStack(alignment: .bottomLeading) {
                                            Image("Cavity")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                            VStack(alignment: .leading) {
                                                Text("测试")
                                                    .font(.largeTitle)
                                                
                                                Text("牙齿敏感情况")
                                                    .font(.title2)
                                            }.padding(.horizontal)
                                        }
                                    }
                                }
                                
                                Button {} label: {
                                    Card(color: Color(0xA9FDC0)) {
                                        ZStack(alignment: .bottomLeading) {
                                            Image("ToothXraySpot")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                            VStack(alignment: .leading) {
                                                Text("修改")
                                                    .font(.largeTitle)
                                                Text("牙齿敏感情况")
                                                    .font(.title2)
                                            }.padding(.horizontal)
                                        }
                                    }
                                }
                            }.foregroundColor(Color(0x35444C))
                                .fontWeight(.bold)
                                .frame(height: 220)
                                .padding()
                            
                            Button(action: {}, label: {
                                Text("退出当前帐号")
                                    .fontWeight(.medium).padding(.vertical, 12)
                            }).buttonStyle(RoundedAndShadowButtonStyle(foregroundColor: Color(0x606060), backgroundColor: Color(0xA5A5A5, 0.14), cornerRadius: 10)).padding(.horizontal, 70)
                        }.padding(.bottom)
                            .padding(.bottom, MyTabBar.height)
                    }
                }
            }
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView(
            store: Store(
                initialState: Mine.State(),
                reducer: Mine()
            )
        )
    }
}
#endif
