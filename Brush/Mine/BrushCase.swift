//
//  BrushCase.swift
//  Brush
//
//  Created by cxq on 2023/8/16.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI
import SwiftUIPager

// MARK: - Feature domain

struct BrushCase: ReducerProtocol {
    struct State: Equatable {
        var scoreList: [ScoreEntity] = []
        @BindingState var date: Date = .now
        @BindingState var isDatePickerVisible: Bool = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case showDatePicker
        case updateDate
        case updateCompleted([ScoreEntity])
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .showDatePicker:
                    state.isDatePickerVisible = true
                    return .none
                case .updateDate:
                    // todo
//                    if let userId = DataUtil.getUser()?.id {
//                        return .task { [date = state.date.formattedString()] in
//                            let response: Response<[ScoreEntity]?> = try await ApiClient.request(Url.scoreRecord + "/\(userId)" + "/\(date)", method: .GET)
//                            if response.code == 200 {
//                                let scoreList: [ScoreEntity] = response.data!!
//                                return .updateCompleted(scoreList)
//                            }
//                            return .updateCompleted([])
//                        }
//                    } else {
//                        return Effect.send(.updateCompleted([]))
//                    }
                    return Effect.send(.updateCompleted(TestData.scoreList))

                case let .updateCompleted(score):
                    state.scoreList = score
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct BrushCaseView: View {
    let store: StoreOf<BrushCase>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            GeometryReader { geo in
                let width = geo.size.width
                ZStack {
                    VStack {
                        Spacer()
                        Image("BgBottom")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width)
                    }.edgesIgnoringSafeArea(.bottom)

                    VStack {
                        HStack {
                            Spacer()
                            DatePicker("", selection: vStore.binding(\.$date), displayedComponents: .date)
                                .fixedSize()
                                .labelsHidden()
                            Spacer()
                        }.padding(.top)
                            .task(id: vStore.date) {
                                vStore.send(.updateDate)
                            }
                        if vStore.scoreList.isEmpty {
                            EmptyPageView()
                        } else {
                            VTabView {
                                ForEach(vStore.scoreList) { score in
                                    OneBrushCase(score: score)
                                }
                            }.tabViewStyle(.page(indexDisplayMode: .always))
                                .onAppear {
                                    UIPageControl.appearance().currentPageIndicatorTintColor = .init(red: 0.49, green: 0.89, blue: 0.82, alpha: 1)
                                    UIPageControl.appearance().pageIndicatorTintColor = .init(red: 0.38, green: 0.86, blue: 0.78, alpha: 0.2)
                                }
                        }
                    }.edgesIgnoringSafeArea(.bottom)
                }
            }.background(Color.bgWhite)
        }
    }
}

struct OneBrushCase: View {
    var score: ScoreEntity
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            VStack {
                CircleScore(timeScore: score.timeScore, freqScore: score.frequencyScore, powerScore: score.powerScore)
                    .frame(width: width * 0.7, height: width * 0.7)
                ScoreRow(timeScore: score.timeScore, freqScore: score.frequencyScore, powerScore: score.powerScore)
                ResultPageView(score: score)
                Spacer()
            }
        }
    }
}

struct ScoreRow: View {
    let timeScore: Int
    let freqScore: Int
    let powerScore: Int
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("时长评分").font(.caption)
                    Text("\(timeScore)/100").foregroundColor(.init(0x7DEED3))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("频率评分").font(.caption)
                    Text("\(freqScore)/100").foregroundColor(.init(0x91E3FB))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("力度评分").font(.caption)
                    Text("\(powerScore)/100").foregroundColor(.init(0x5D8FEF))
                }
                Spacer()
            }.font(.title)
                .fontWeight(.bold)
            // TODO: totalScore
            TwoWord(first: "\(Int((powerScore + timeScore + freqScore) / 3))", second: "分",
                    firstFont: .system(size: UIFont.textStyleSize(.largeTitle) * 1.5), secondColor: .primary)
            Text("你还可以做得更好！").font(.caption).foregroundColor(.fontGray)
        }
    }
}

// extension Text {
//    public func foregroundLinearGradient(
//        colors: [Color],
//        startPoint: UnitPoint,
//        endPoint: UnitPoint) -> some View
//    {
//        self.overlay {
//            LinearGradient(
//                colors: colors,
//                startPoint: startPoint,
//                endPoint: endPoint
//            )
//            .mask(
//                self
//
//            )
//        }
//    }
// }

struct ResultPageView: View {
    var indices: [Int]
    var minScore: [(Int, Int)]
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
        "左下舌侧",
    ]

    init(score: ScoreEntity) {
        let indices = ListUtil.findMinIndices(score.areaTotalScoreList, 5)
        self.indices = indices
        self.minScore = []
        for i in indices {
            let t = minIndexAndValue(
                score.areaTimeScoreList[i],
                score.areaFrequencyScoreList[i],
                score.areaPowerScoreList[i]
            )
            minScore.append(t)
        }

        func minIndexAndValue(_ a: Int, _ b: Int, _ c: Int) -> (Int, Int) {
            var i = 0
            var s = a
            if b < a && b < c {
                i = 1
                s = b
            }
            if c < a && c < b {
                i = 2
                s = c
            }
            return (i, s)
        }
    }

    @ViewBuilder
    func OnePage(index: Int) -> some View {
        if index == 0 {
            GeometryReader { geometry in
                let widthHalf = geometry.size.width / 2
                let heightHalf = geometry.size.height / 2
                ZStack {
                    Group {
                        HotWord(hotWords[indices[0]], paddingH: 4, paddingV: 4)
                            .offset(x: widthHalf * 0.6, y: -heightHalf * 0.7)
                        HotWord(hotWords[indices[1]], paddingH: 4, paddingV: 4)
                            .offset(x: -widthHalf * 0.5, y: -heightHalf * 0.45)
                        HotWord(hotWords[indices[2]], paddingH: 5, paddingV: 5)
                            .offset(x: widthHalf * 0.17, y: -heightHalf * 0.08)
                        HotWord(hotWords[indices[3]], paddingH: 3, paddingV: 3)
                            .offset(x: -widthHalf * 0.5, y: heightHalf * 0.26)
                        HotWord(hotWords[indices[4]], paddingH: 4, paddingV: 4)
                            .offset(x: widthHalf * 0.6, y: heightHalf * 0.44)
                    }.foregroundColor(Color(0x76CCBE))

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("ToothXraySpot")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("本次总结")
                                .font(.body)
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }.padding(.bottom, 10)
                }
            }
        } else {
            SectionResultView(section: hotWords[indices[index - 1]], minScore: minScore[index - 1])
        }
    }

    var body: some View {
        Pager(page: .first(),
              data: [0, 1, 2, 3, 4, 5],
              id: \.self,
              content: { index in
                  OnePage(index: index)
                      .frame(width: 150, height: 220)
                      .background(.white)
                      .cornerRadius(10)
                      .overlay(
                          RoundedRectangle(cornerRadius: 6)
                              .inset(by: 0.5)
                              .stroke(Color(red: 0.89, green: 0.9, blue: 0.92), lineWidth: 1)
                      )
              }).itemAspectRatio(0.7)
            .interactive(scale: 0.8)
            .loopPages()
            .draggingAnimation(.interactive)
            .frame(height: 260)
    }
}

struct SectionResultView: View {
    var section: String
    var minScore: (Int, Int)
    //    var point0: String
    //    var point1: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                //                RoundedRectangle(cornerRadius: 10)
                //                    .fill(Color(0xDAFDEE))
                //                    .frame(width: 8, height: 30)
                //                    .padding(.leading, 2)
                VStack(alignment: .leading, spacing: 3) {
                    Text(section + "面")
                        .fontWeight(.bold)
                    //                    HStack {
                    //                        Circle()
                    //                            .frame(width: 5, height: 5)
                    //                        Text(point0)
                    //                            .font(.caption2)
                    //                    }.foregroundColor(.fontGray)
                    //                    HStack {
                    //                        Circle()
                    //                            .frame(width: 5, height: 5)
                    //                        Text(point1)
                    //                            .font(.caption2)
                    //                    }.foregroundColor(.fontGray)
                }
            }
            Spacer()
            if minScore.0 == 0 {
                CircleScore(timeScore: minScore.1, freqScore: 0, powerScore: 0)
            } else if minScore.0 == 1 {
                CircleScore(timeScore: 0, freqScore: minScore.1, powerScore: 0)
            } else if minScore.0 == 2 {
                CircleScore(timeScore: 0, freqScore: 0, powerScore: minScore.1)
            }
            Spacer()
            HStack {
                Spacer()
                Image("ResultIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text(minScore.0 == 1 ? "时长评分" : (minScore.0 == 2 ? "频率评分" : "力度评分"))
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
            }
            Spacer()
        }.padding(.bottom, 10)
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct BrushCaseView_Previews: PreviewProvider {
    static var previews: some View {
        BrushCaseView(
            store: Store(
                initialState: BrushCase.State(),
                reducer: BrushCase()
            )
        )
    }
}
#endif
