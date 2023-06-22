//
//  Analysis.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI


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
        Color(0xEEEEEE, alpha: 0.34),
    ]
    
    let monthE = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep", "Oct", "Nev", "Dec"]
    
    let monthC = ["一月", "二月", "三月", "四月", "五月", "六月",
                  "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            ScrollView(showsIndicators: false) {
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
                        ZStack(alignment: .trailing) {
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
                                Spacer()
                            }.padding(.horizontal, 25)
                            Image("BrushBg")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 110)
                        }
                        .padding(.vertical)
                        
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
                    
                    HStack(alignment: .top, spacing: 15) {
                        VStack(spacing: 15) {
                            Card(color: Color(0x003FE2, alpha: 0.44), height: 150, backgroundOpacity: 0.5) {
                                VStack {
                                    Text("历史最高分")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("98")
                                        .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("月度最高Top")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                }
                            }
                            Card(color: Color(0xFFE193, alpha: 0.72), height: 200) {
                                VStack(spacing: 0) {
                                    Spacer()
                                    Image("ScoreLine")
                                    Text("评分曲线 Monthly")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 20)
                                }
                            }
                        }
                        VStack(spacing: 15) {
                            Card(color: Color(0x00C4DF, alpha: 0.40), height: 100, backgroundOpacity: 0.5) {
                                VStack {
                                    HStack {
                                        Image("BrushMin")
                                        ProgressView(value: 0.5)
                                            .progressViewStyle(RoundedRectProgressViewStyle())
                                            .frame(width: 90)
                                        Image("BrushMax")
                                    }
                                    Text("平均力度 Average")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                }
                            }
                            GeometryReader { _ in
                                ZStack {
                                    Card(color: Color(0xA684C8), height: 250, backgroundOpacity: 0.5) {
                                        VStack {
                                            Spacer()
                                            Text("热词 Conclusion")
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .padding(.bottom, 20)
                                        }
                                    }
                                }.overlay(
                                    HotWord("刷轻啦")
                                        .offset(x: 50, y: -80)
                                ).overlay(
                                    HotWord("外左上", paddingH: 10, paddingV: 10)
                                        .offset(x: -40, y: -65)
                                ).overlay(
                                    HotWord("内右上")
                                        .offset(x: 15, y: -10)).overlay(
                                            HotWord("再用点劲", paddingH: 12, paddingV: 12)
                                                .offset(x: -50, y: 45)
                                        ).overlay(
                                            HotWord("外左上", paddingH: 10, paddingV: 10)
                                                .offset(x: 45, y: 55)
                                                .padding(.all)
                                        )
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

struct HotWord: View {
    var content: String
    var paddingH: CGFloat
    var paddingV: CGFloat
    init(_ content: String, paddingH: CGFloat = 20, paddingV: CGFloat = 15) {
        self.content = content
        self.paddingV = paddingV
        self.paddingH = paddingH
    }
    
    var body: some View {
        Text(content)
            .padding(.horizontal, paddingH)
            .padding(.vertical, paddingV)
            .fontWeight(.semibold)
            .background(Color(0xF2F7F5))
            .foregroundColor(Color(0x9272A1))
            .cornerRadius(5)
            .shadow(color: Color(0x000000, alpha: 0.25), radius: 5, x: 2, y: 4)
    }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 90, height: 8)
                .foregroundColor(Color(0xD0D0D0, alpha: 0.2))
            RoundedRectangle(cornerRadius: 5)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 90, height: 8)
                .foregroundColor(.white)
        }
        .padding()
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
