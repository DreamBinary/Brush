//
//  Analysis.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI
import WaterfallGrid

// MARK: - Feature domain

struct Analysis: ReducerProtocol {
    struct State: Equatable {
        var currMonth = 4 // from 0 start
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onTapMonth(Int)
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
                case let .onTapMonth(month):
                    state.currMonth = month
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct AnalysisView: View {
    let store: StoreOf<Analysis>
    
    let backgroundColors: [Color] = [
        Color(0x7DE2D1, alpha: 1),
        Color(0x9BEADC, alpha: 0.69),
        Color(0xCAFBF3, alpha: 1),
        Color(0xBAFEF3, alpha: 0.52),
        Color(0xDBFFF9, alpha: 0.25),
        Color(0xEEEEEE, alpha: 0.34)
    ]
    
    let monthE = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep", "Oct", "Nev", "Dec"]
    
    let monthC = ["一月", "二月", "三月", "四月", "五月", "六月",
                  "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    HStack(spacing: 15) {
                        Avatar()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hi, Worsh!")
                                .font(.title2.bold())
                            Text("Are you ready for your new journey?")
                                .font(.callout)
                                .foregroundColor(.lightBlack)
                        }
                    }
                    Card(color: Color(0xE1F5B3), cornerRadius: 15) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("New TuneBrush Journey")
                                    .font(.title2.bold())
                                    .padding(.bottom, 1)
                                
                                Text("预计进行 12min      现在就开始！")
                                    .foregroundColor(.lightBlack)
                                    .font(.callout)
                                
                                Text("Get Started！")
                                    .font(.title2.bold())
                                    .underline()
                                    .padding(.top, 10)
                            }
                            Image("avatar")
                        }
                        .padding()
                    }.frame(height: 150)
                    Text("Your Analysis")
                        .font(.title2.bold())
                        .padding(.horizontal)
                    ScrollViewReader { scrollViewProxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 12) { index in
                                    (
                                        vStore.currMonth == index
                                        ? Card(color: Color(0x365869), cornerRadius: 15) {
                                            VStack(spacing: 10) {
                                                Text(monthC[index])
                                                    .font(.callout)
                                                    .foregroundColor(.white)
                                                Text(monthE[index])
                                                    .font(.title.bold())
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        : Card(color: .white.opacity(0.44), cornerRadius: 15) {
                                            VStack(spacing: 10) {
                                                Text(monthC[index])
                                                    .font(.callout)
                                                    .foregroundColor(.gray)
                                                Text(monthE[index])
                                                    .font(.title.bold())
                                            }
                                        }
                                    ).frame(width: 80, height: 100)
                                        .id(monthE[index])
                                        .onTapGesture {
                                            vStore.send(.onTapMonth(index))
                                            scrollViewProxy.scrollTo(monthE[vStore.currMonth], anchor: .center)
                                        }
                                }
                            }
                        }.onAppear {
                            scrollViewProxy.scrollTo(monthE[vStore.currMonth], anchor: .center)
                        }
                    }
                    
                    WaterfallGrid(0 ..< 12, id: \.self) { index in
                        Card(color: Color(0xDDC0F9), height: CGFloat(Float.random(in: 150...300))) {
                            VStack {
                                Text("历史最高分")
                                    .font(.body)
                                    .foregroundColor(.white)
                                Text("98")
                                    .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("月度最高Top")
                                    .font(.callout)
                            }
                        }.padding(.vertical)
                    }
                    
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView(
            store: Store(
                initialState: Analysis.State(),
                reducer: Analysis()
            )
        )
    }
}
#endif

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
