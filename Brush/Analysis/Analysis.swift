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
        var name: String = "Worsh"
        var curMonth: Int = Date().monthNum() // from 1 start
        var monthlyTop: Int = 0
        var avgPower: Double = 0
        var hotArea: [Int] = []
        var analysisSection: AnalysisSection.State? = nil
        var hasTopData: Bool = false
        var hasHotAreaData: Bool = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case analysisSection(AnalysisSection.Action)
        case analysisSectionInit
        case nameInit
        case onTapGetStarted
        case onTapMonth(Int)
        case updateMonthlyTop
        case updateMonthlyTopCompleted(Int)
        case updateAvg
        case updateAvgCompleted
        case updateHotword
        case updateHotwordCompleted([Int])
        case noTopData
        case noHotAreaData
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding, .analysisSection:
                    return .none
            case .nameInit:
                state.name = DataUtil.getUser()?.username ?? "Worsh"
                return .none
                case .analysisSectionInit:
                    state.analysisSection = nil
                    return Effect.merge(
                        Effect.send(Analysis.Action.updateHotword),
                        Effect.send(Analysis.Action.updateMonthlyTop),
                        Effect.send(Analysis.Action.updateAvg)
                    )
//
//                case .analysisSectionCompleted:
//                    state.analysisSection = AnalysisSection.State(topScore: state.monthlyTop, avgPower: state.avgPower)
//                    return .none
                case .updateMonthlyTop:
                    if let userId = DataUtil.getUser()?.id {
                        return .task { [month = state.curMonth] in
                            let date = "\(Date().yearNum())-\(month)-1"
                            let response: Response<ScoreEntity?> = try await ApiClient.request(Url.monthTop + "/\(userId)" + "/\(date)", method: .GET)
                            if response.code == 200 {
                                let score: ScoreEntity = response.data!!
                                return .updateMonthlyTopCompleted(score.totalScore)
                            }
                            return .noTopData
                        }
                    } else {
                        return Effect.send(.noTopData)
                    }
                case let .updateMonthlyTopCompleted(score):
                    if state.analysisSection == nil {
                        state.analysisSection = AnalysisSection.State(topScore: score, curMonth: state.curMonth)
                    } else {
                        state.analysisSection?.topScore = score
                    }
                    state.hasTopData = true
                    return .none
                case .updateAvg:
                    // TODO:
                    return .task {
                        try await Task.sleep(nanoseconds: 5_000_000)
                        return .updateAvgCompleted
                    }
                case .updateHotword:
                    if let userId = DataUtil.getUser()?.id {
                    
                        return .task { [month = state.curMonth] in
                            let date = "\(Date().yearNum())-\(month)-1"
                            let response: Response<HotArea?> = try await ApiClient.request(Url.hotword + "/\(userId)" + "/\(date)", method: .GET)
                            if response.code == 200 {
                                let score: HotArea = response.data!!
                                return .updateHotwordCompleted(score.hotArea)
                            }
                            return .noHotAreaData
                        }
                    } else {
                        return Effect.send(.noHotAreaData)
                    }
                    
                case let .updateHotwordCompleted(hotArea):
                    if state.analysisSection == nil {
                        state.analysisSection = AnalysisSection.State(hotArea: hotArea, curMonth: state.curMonth)
                    } else {
                        state.analysisSection?.hotArea = hotArea
                    }
                    state.hasHotAreaData = true
                    return .none
                case .updateAvgCompleted:
                    if state.analysisSection == nil {
                        state.analysisSection = AnalysisSection.State(avgPower: 0.65, curMonth: state.curMonth)
                    } else {
                        state.analysisSection?.avgPower = 0.65
                    }
                    return .none
                case .onTapGetStarted:
                    return .none
                case .noTopData:
                    state.hasTopData = false
                    return .none
                case .noHotAreaData:
                    state.hasHotAreaData = false
                    return .none
                case let .onTapMonth(month):
                    state.curMonth = month
                    return Effect.send(.analysisSectionInit)
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
                    if (!vStore.hasTopData && !vStore.hasHotAreaData) {
                        EmptyPageView(onTap: {vStore.send(.onTapGetStarted)})
                    } else {
                        AnalysisSectionView(store: $0)
                    }
                } else: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }.clipped()
                .background(
                    LinearGradient(gradient: Gradient(colors: self.backgroundColors), startPoint: .top, endPoint: .bottom)
                ).onAppear {
                    vStore.send(.analysisSectionInit)
                    vStore.send(.nameInit)
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

    @State private var value: Double = 0.0
    @State private var toAvg: Bool = false

    var body: some View {
        Card(color: Color(0x00C4DF, 0.40), backgroundOpacity: 0.5) {
            VStack {
                HStack {
                    Image("BrushMin")
                    ProgressView(value: value)
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .frame(width: 90)
                        .onAppear {
                            animate()
                        }.onTapGesture {
                            animate()
                        }.task(id: avgPower) {
                            animate()
                        }
                    Image(toAvg ? "BrushMax" : "BrushMin")
                }
                Text("平均力度 Average")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.lightBlack)
            }
        }
    }

    func animate() {
        value = 0
        toAvg = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.5)) {
                value = avgPower
                toAvg = true
            }
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
                            .onAppear {
                                animate()
                            }
                    }.frame(height: height*0.6)
                        .padding(.horizontal, width*0.01)
                        .padding(.bottom)

                    Text("评分曲线 Monthly")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                        .foregroundColor(.lightBlack)
                }
            }
        }
    }

    func animate() {
        value = 0
        withAnimation(.easeInOut(duration: 1)) {
            value = 1
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
    var hotList: [Int]
    var hotWords: [String] = [
        "右上颊侧",
        "左上颊侧",
        "右上咬合",
        "左上咬合",
        "右上舌侧",
        "左上舌侧",
        "右下颊侧",
        "左下颊侧",
        "右下咬合",
        "左下咬合",
        "右下舌侧",
        "左下舌侧"
    ]

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
                    if !hotList.isEmpty {
                        HotWord(hotWords[hotList[0]],paddingH: 15)
                            .offset(x: widthHalf*0.6, y: -heightHalf*0.7)
                        HotWord(hotWords[hotList[1]],
                                paddingH: 10, paddingV: 10)
                        .offset(x: -widthHalf*0.5, y: -heightHalf*0.52)
                        HotWord(hotWords[hotList[2]])
                            .offset(x: widthHalf*0.17, y: -heightHalf*0.08)
                        HotWord(hotWords[hotList[3]],
                                paddingH: 12, paddingV: 12)
                        .offset(x: -widthHalf*0.6, y: heightHalf*0.36)
                        HotWord(hotWords[hotList[4]],
                                paddingH: 10, paddingV: 10)
                        .offset(x: widthHalf*0.52, y: heightHalf*0.44)
                    }
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
