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
        var name: String = DataUtil.getUser()?.username ?? "Worsh"
        var curMonth: Int = Date().monthNum() // from 1 start
        var analysisSection: AnalysisSection.State?
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case analysisSection(AnalysisSection.Action)
        case analysisSectionInit
        case analysisSectionCompleted
        case onTapGetStarted
        case onTapMonth(Int)
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding, .analysisSection:
                    return .none
                case .analysisSectionInit:

                    return Effect.send(.analysisSectionCompleted)

                case .analysisSectionCompleted:
                    state.analysisSection = AnalysisSection.State()
                    return .none
                case .onTapGetStarted:
                    return .none
                case let .onTapMonth(month):
                    state.curMonth = month
                    return .none
            }
        }.ifLet(\.analysisSection, action: /Action.analysisSection) {
            AnalysisSection()
        }
    }
}

// MARK: - Feature view

struct AnalysisView: View {
    let store: StoreOf<Analysis>

    private let backgroundColors: [Color] = [
        Color(0x7DE2D1, 1),
        Color(0x9BEADC, 0.69),
        Color(0xCAFBF3, 1),
        Color(0xBAFEF3, 0.52),
        Color(0xDBFFF9, 0.25),
        Color.bgWhite
    ]

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            VStack(alignment: .leading, spacing: 10) {
                Person(name: vStore.name, label: "Are you ready for your new journey?")

                StartCard(onGetStarted: { vStore.send(.onTapGetStarted) })

                Text("Your Analysis")
                    .font(.title2.bold())
                    .padding(.horizontal)
                    .padding(.horizontal)

                MonthRow(curMonth: vStore.curMonth) { index in
                    vStore.send(.onTapMonth(index + 1))
                }

                IfLetStore(self.store.scope(state: \.analysisSection, action: Analysis.Action.analysisSection)) {
                    AnalysisSectionView(store: $0)
                } else: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight:.infinity)
                }
            }.clipped()
                .background(
                    LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .top, endPoint: .bottom)
                ).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        vStore.send(.analysisSectionInit)
                    }
                }
        }
    }
}

struct Person: View {
    var name: String
    var label: String
    var body: some View {
        HStack(spacing: 15) {
            Avatar(fillColor: Color(0xADB4F2))
            VStack(alignment: .leading, spacing: 5) {
                Text("Hi, \(name)!")
                    .font(.title2.bold())
                Text("\(label)")
                    .font(.callout)
                    .foregroundColor(.lightBlack)
            }
        }.padding(.horizontal)
    }
}

struct StartCard: View {
    var onGetStarted: () -> Void
    var body: some View {
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
                        Text("预计进行 2.5 min      现在就开始！")
                            .foregroundColor(.lightBlack)
                            .font(.callout)
                        Text("Get Started！")
                            .font(.title2.bold())
                            .underline()
                            .padding(.top, 10)
                            .onTapGesture {
                                onGetStarted()
                            }
                    }
                    Spacer()
                }.padding(.horizontal, 25)
            }.padding(.vertical)
        }.padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct Top: View {
    var score: Int
    @State private var value: Int = 0
    var body: some View {
        Card(color: Color(0x003FE2, 0.44), backgroundOpacity: 0.5) {
            VStack {
//                Text("历史最高分")
//                    .font(.body)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)

                AnimNum(num: score, changeNum: $value) {
                    Text("\(value)")
                        .font(.system(size: UIFont.textStyleSize(.largeTitle)*2))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

                Text("月度最高 Top")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct Average: View {
    var avgPower: Double

    @State private var currentProgress: Double = 0.0
    @State private var toAvg: Bool = false

    var body: some View {
        Card(color: Color(0x00C4DF, 0.40), backgroundOpacity: 0.5) {
            VStack {
                HStack {
                    Image("BrushMin")
                    ProgressView(value: toAvg ? avgPower : 0.0)
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .frame(width: 90)
                        .onAppear {
                            startAnimation(duration: 0.3)
                        }
                        .onTapGesture {
                            startAnimation(duration: 0.3)
                        }
                    Image(toAvg ? "BrushMax" : "BrushMin")
                }.animation(.easeInOut(duration: 0.5), value: toAvg)
                Text("平均力度 Average")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.lightBlack)
            }
        }
    }

    func startAnimation(duration: Double) {
        currentProgress = 0
        toAvg = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            toAvg = true
        }
    }
}

struct Mothly: View {
    @State private var value: CGFloat = 0
    private let color: Color = .init(0xF3A53F)
    var body: some View {
        Card(color: Color(0xFFE193, 0.72)) {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                VStack(spacing: 0) {
                    Spacer()
                    //                Image("ScoreLine")
                    ZStack {
                        AreaShape()
                            .fill(LinearGradient(colors: [color.opacity(0.6), color.opacity(0)], startPoint: .top, endPoint: .bottom))
                        LineShape()
                            .trim(from: 0, to: value)
                            .stroke(
                                LinearGradient(colors: [color.opacity(0.5), color], startPoint: .leading, endPoint: .trailing),
                                style: StrokeStyle(
                                    lineWidth: 5,
                                    lineCap: .round
                                )
                            )
                    }.frame(height: height*0.6)
                        .padding(.horizontal, width*0.01)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1)) {
                                value = 1
                            }
                        }.padding(.bottom)

                    Text("评分曲线 Monthly")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                        .foregroundColor(.lightBlack)
                }
            }
        }
    }
}

struct LineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.88674*height))
        path.addCurve(to: CGPoint(x: 0.21273*width, y: 0.59881*height), control1: CGPoint(x: 0, y: 0.88674*height), control2: CGPoint(x: 0.11962*width, y: 0.63079*height))
        path.addCurve(to: CGPoint(x: 0.39817*width, y: 0.73459*height), control1: CGPoint(x: 0.28661*width, y: 0.57344*height), control2: CGPoint(x: 0.32413*width, y: 0.75455*height))
        path.addCurve(to: CGPoint(x: 0.67175*width, y: 0.01691*height), control1: CGPoint(x: 0.53599*width, y: 0.69742*height), control2: CGPoint(x: 0.5351*width, y: -0.0515*height))
        path.addCurve(to: CGPoint(x: 0.8663*width, y: 0.59881*height), control1: CGPoint(x: 0.77464*width, y: 0.06843*height), control2: CGPoint(x: 0.76248*width, y: 0.5727*height))
        path.addCurve(to: CGPoint(x: width, y: 0.50183*height), control1: CGPoint(x: 0.9174*width, y: 0.61166*height), control2: CGPoint(x: 0.99398*width, y: 0.50183*height))
        return path
    }
}

struct AreaShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.88674*height))
        path.addCurve(to: CGPoint(x: 0.21273*width, y: 0.59881*height), control1: CGPoint(x: 0, y: 0.88674*height), control2: CGPoint(x: 0.11962*width, y: 0.63079*height))
        path.addCurve(to: CGPoint(x: 0.39817*width, y: 0.73459*height), control1: CGPoint(x: 0.28661*width, y: 0.57344*height), control2: CGPoint(x: 0.32413*width, y: 0.75455*height))
        path.addCurve(to: CGPoint(x: 0.67175*width, y: 0.01691*height), control1: CGPoint(x: 0.53599*width, y: 0.69742*height), control2: CGPoint(x: 0.5351*width, y: -0.0515*height))
        path.addCurve(to: CGPoint(x: 0.8663*width, y: 0.59881*height), control1: CGPoint(x: 0.77464*width, y: 0.06843*height), control2: CGPoint(x: 0.76248*width, y: 0.5727*height))
        path.addCurve(to: CGPoint(x: width, y: 0.50183*height), control1: CGPoint(x: 0.9174*width, y: 0.61166*height), control2: CGPoint(x: 0.99398*width, y: 0.50183*height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}

struct Conclusion: View {
    var body: some View {
        GeometryReader { geo in
            let widthHalf = geo.size.width / 2
            let heightHalf = geo.size.height / 2
            ZStack {
                Card(color: Color(0xA684C8), backgroundOpacity: 0.5) {
                    VStack {
                        Spacer()
                        Text("热词 Conclusion")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.bottom)
                            .foregroundColor(.lightBlack)
                    }
                }
                Group {
                    HotWord("刷轻啦")
                        .offset(x: widthHalf*0.6, y: -heightHalf*0.64)
                    HotWord("外左上",
                            paddingH: 10, paddingV: 10)
                        .offset(x: -widthHalf*0.5, y: -heightHalf*0.52)
                    HotWord("内右上")
                        .offset(x: widthHalf*0.17, y: -heightHalf*0.08)
                    HotWord("再用点劲",
                            paddingH: 12, paddingV: 12)
                        .offset(x: -widthHalf*0.6, y: heightHalf*0.36)
                    HotWord("外左上",
                            paddingH: 10, paddingV: 10)
                        .offset(x: widthHalf*0.52, y: heightHalf*0.44)
                }.foregroundColor(Color(0x9272A1))
            }
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
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0)*90, height: 8)
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
