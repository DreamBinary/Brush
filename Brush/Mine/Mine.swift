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
        var name: String = "Conan Worsh"
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
        WithViewStore(self.store, observe: { $0 }) { vStore in
            GeometryReader { geo in
                let height = geo.size.height
                let width = geo.size.width
                ZStack(alignment: .center) {
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .frame(height: height * 0.8)
                                .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99))
                                .cornerRadius(corners: [.topLeft, .topRight], radius: 16)
                            
                            VStack {
                                Spacer(minLength: width * 0.5 * sqrt(6) / 4)
                                VStack(spacing: 5) {
                                    Text(vStore.name)
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
                                    }.padding(.top)
                                        
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
                                                        HStack(alignment: .firstTextBaseline) {
                                                            Text("93")
                                                                .font(.largeTitle.bold())
                                                            Text("分")
                                                                .font(.callout)
                                                        }
                                                        Text("查看刷牙情况")
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
                                                        HStack(alignment: .firstTextBaseline) {
                                                            Text("16")
                                                                .font(.largeTitle.bold())
                                                            Text("天")
                                                                .font(.callout)
                                                        }
                                                        Text("牙刷更换情况")
                                                            .font(.title2)
                                                    }.padding(.horizontal)
                                                }
                                            }
                                        }
                                    }.foregroundColor(Color(0x35444C))
                                        .fontWeight(.semibold)
                                        .padding()
           
                                    Button(action: {}, label: {
                                        Text("退出当前帐号")
                                            .fontWeight(.medium)
                                            .padding(.vertical, 12)
                                    }).buttonStyle(RoundedAndShadowButtonStyle(foregroundColor: Color(0x606060), backgroundColor: Color(0xA5A5A5, 0.14), cornerRadius: 10))
                                        .frame(width: width * 0.7)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }.frame(height: height * 0.8)
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: width * 0.5, height: width * 0.5)
                            .foregroundColor(Color(0xA9C1FD))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0), radius: 14.5, x: 48, y: -93)
                            .shadow(color: .black.opacity(0.01), radius: 13.5, x: 31, y: -59)
                            .shadow(color: .black.opacity(0.05), radius: 11.5, x: 17, y: -33)
                            .shadow(color: .black.opacity(0.09), radius: 8.5, x: 8, y: -15)
                            .shadow(color: .black.opacity(0.1), radius: 4.5, x: 2, y: -4)
                            .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
                            .rotationEffect(Angle(degrees: -15))
                        Avatar(radius: width * 0.2, fillColor: Color(0xB5EEC4))
                    }.offset(y: -height * 0.3)
                }.frame(width: width, height: height)
            }
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.49, green: 0.89, blue: 0.82), location: 0.05),
                        Gradient.Stop(color: Color(red: 0.61, green: 0.92, blue: 0.86), location: 0.47),
                        Gradient.Stop(color: Color(red: 0.09, green: 0.76, blue: 0.65), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.55, y: 0.02),
                    endPoint: UnitPoint(x: 0.98, y: 1)
                )
            )
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
