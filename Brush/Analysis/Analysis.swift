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
        var curMonth = 5 // from 1 start
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
                    state.curMonth = month
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct AnalysisView: View {
    let store: StoreOf<Analysis>

    let backgroundColors: [Color] = [
        Color(0x7DE2D1, 1),
        Color(0x9BEADC, 0.69),
        Color(0xCAFBF3, 1),
        Color(0xBAFEF3, 0.52),
        Color(0xDBFFF9, 0.25),
        Color(0xEEEEEE, 0.34),
    ]

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            GeometryReader { _ in
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 15) {
                        Avatar(fillColor: Color(0xADB4F2))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hi, Worsh!")
                                .font(.title2.bold())
                            Text("Are you ready for your new journey?")
                                .font(.callout)
                                .foregroundColor(.lightBlack)
                        }
                    }.padding(.horizontal)
                    Card(color: Color(0xE1F5B3), cornerRadius: 15) {
                        ZStack(alignment: .trailing) {
                            Image("BrushBg")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 110)
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
                        }.padding(.vertical)
                    }.padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("Your Analysis")
                        .font(.title2.bold())
                        .padding(.horizontal)
                        .padding(.horizontal)

                    MonthRow(curMonth: vStore.curMonth) { index in
                        vStore.send(.onTapMonth(index + 1))
                    }

                    GeometryReader { geo in
                        let height = geo.size.height - 15
                        HStack(alignment: .top, spacing: 15) {
                            VStack(spacing: 15) {
                                Card(color: Color(0x003FE2, 0.44), backgroundOpacity: 0.5) {
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
                                }.frame(height: height * 0.4)
                                Card(color: Color(0xFFE193, 0.72)) {
                                    VStack(spacing: 0) {
                                        Spacer()
                                        Image("ScoreLine")
                                        Text("评分曲线 Monthly")
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .padding(.bottom)
                                    }
                                }.frame(height: height * 0.6)
                            }
                            VStack(spacing: 15) {
                                Card(color: Color(0x00C4DF, 0.40), backgroundOpacity: 0.5) {
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
                                }.frame(height: height * 0.25)
                                GeometryReader { geometry in
                                    let widthHalf = geometry.size.width / 2
                                    let heightHalf = geometry.size.height / 2

                                    ZStack {
                                        Card(color: Color(0xA684C8), backgroundOpacity: 0.5) {
                                            VStack {
                                                Spacer()
                                                Text("热词 Conclusion")
                                                    .font(.callout)
                                                    .fontWeight(.semibold)
                                                    .padding(.bottom)
                                            }
                                        }.frame(height: height * 0.75)
                                        Group {
                                            HotWord("刷轻啦")
                                                .offset(x: widthHalf * 0.6, y: -heightHalf * 0.64)
                                            HotWord("外左上",
                                                    paddingH: 10, paddingV: 10)
                                                .offset(x: -widthHalf * 0.5, y: -heightHalf * 0.52)
                                            HotWord("内右上")
                                                .offset(x: widthHalf * 0.17, y: -heightHalf * 0.08)
                                            HotWord("再用点劲",
                                                    paddingH: 12, paddingV: 12)
                                                .offset(x: -widthHalf * 0.6, y: heightHalf * 0.36)
                                            HotWord("外左上",
                                                    paddingH: 10, paddingV: 10)
                                                .offset(x: widthHalf * 0.52, y: heightHalf * 0.44)
                                        }.foregroundColor(Color(0x9272A1))
                                            .shadow(color: Color(0x000000, 0.25), radius: 5, x: 2, y: 4)
                                    }
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
                .clipped()
            }.background(
                LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 90, height: 8)
                .foregroundColor(Color(0xD0D0D0, 0.2))
            RoundedRectangle(cornerRadius: 5)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 90, height: 8)
                .foregroundColor(.white)
        }
        .padding()
    }
}

struct MonthRow: View {
    var curIndex: Int
    var onTap: (Int) -> Void
    private let monthE = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                          "Jul", "Aug", "Sep", "Oct", "Nev", "Dec"]

    private let monthC = ["一月", "二月", "三月", "四月", "五月", "六月",
                          "七月", "八月", "九月", "十月", "十一月", "十二月"]

    init(curMonth: Int, onTap: @escaping (Int) -> Void) {
        self.curIndex = curMonth - 1
        self.onTap = onTap
    }

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< 12) { index in
                        (
                            curIndex == index
                                ? Card(color: Color(0x365869), cornerRadius: 15) {
                                    VStack(spacing: 10) {
                                        Text(self.monthC[index])
                                            .font(.callout)
                                            .foregroundColor(.white)
                                        Text(self.monthE[index])
                                            .font(.title.bold())
                                            .foregroundColor(.white)
                                    }
                                }
                                : Card(color: .white.opacity(0.44), cornerRadius: 15) {
                                    VStack(spacing: 10) {
                                        Text(self.monthC[index])
                                            .font(.callout)
                                            .foregroundColor(.gray)
                                        Text(self.monthE[index])
                                            .font(.title.bold())
                                            .foregroundColor(Color(0x365869))
                                    }
                                }
                        ).frame(width: 70, height: 90)
                            .id(self.monthE[index])
                            .onTapGesture {
                                scrollViewProxy.scrollTo(self.monthE[index], anchor: .center)
                                onTap(index)
                            }
                    }
                }
            }.onAppear {
                scrollViewProxy.scrollTo(self.monthE[curIndex], anchor: .center)
            }
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
