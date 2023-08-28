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
                    if let userId = DataUtil.getUser()?.id {
                        return .task { [date = state.date.formattedString()] in
                            let response: Response<[ScoreEntity]?> = try await ApiClient.request(Url.scoreRecord + "/\(userId)" + "/\(date)", method: .GET)
                            if response.code == 200 {
                                let scoreList: [ScoreEntity] = response.data!!
                                return .updateCompleted(scoreList)
                            }
                            return .updateCompleted([])
                        }
                    } else {
                        return Effect.send(.updateCompleted([]))
                    }

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
                            TabView {
                                ForEach(vStore.scoreList) { score in
                                    OneBrushCase(score: score)
                                }
                            }.tabViewStyle(.page)
                                .indexViewStyle(.page(backgroundDisplayMode: .always))
                        }
                    }
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
                CircleScore(powerScore: score.powerScore, timeScore: score.timeScore, sectionScore: score.powerScoreList.min() ?? 0)
                    .frame(width: width * 0.7, height: width * 0.7)
                ScoreRow(powerScore: score.powerScore, timeScore: score.timeScore, sectionScore: score.powerScoreList.min() ?? 0)
                ResultPageView()
                Spacer()
            }
        }
    }
}

struct ScoreRow: View {
    let powerScore: Int
    let timeScore: Int
    let sectionScore: Int
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("力度评分").font(.caption)
                    Text("\(powerScore)/100").foregroundColor(.init(0x7DEED3))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("时长评分").font(.caption)
                    Text("\(timeScore)/100").foregroundColor(.init(0x91E3FB))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("片区最低").font(.caption)
                    Text("\(sectionScore)/100").foregroundColor(.init(0x5D8FEF))
                }
                Spacer()
            }.font(.title)
                .fontWeight(.bold)

            TwoWord(first: "\(Int((powerScore + timeScore + sectionScore) / 3))", second: "分",
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
//
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
    var pages: [AnyView] = [
        AnyView(GeometryReader { geometry in
            let widthHalf = geometry.size.width / 2
            let heightHalf = geometry.size.height / 2
            ZStack {
                Group {
                    HotWord("刷轻啦", paddingH: 8, paddingV: 8)
                        .offset(x: widthHalf * 0.6, y: -heightHalf * 0.64)
                    HotWord("外左上", paddingH: 8, paddingV: 8)
                        .offset(x: -widthHalf * 0.5, y: -heightHalf * 0.52)
                    HotWord("内右上", paddingH: 10, paddingV: 10)
                        .offset(x: widthHalf * 0.17, y: -heightHalf * 0.08)
                    HotWord("再用点劲", paddingH: 7, paddingV: 7)
                        .offset(x: -widthHalf * 0.5, y: heightHalf * 0.36)
                    HotWord("外左上", paddingH: 8, paddingV: 8)
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
        }),
        AnyView(SectionResultView(section: "外左上片区", point0: "可以再用点劲", point1: "时长还可以再增加一些哦！")),
        AnyView(SectionResultView(section: "内右下片区", point0: "可以再用点劲", point1: "时长还可以再增加一些哦！")),
        AnyView(GeometryReader { geometry in
            let widthHalf = geometry.size.width / 2
            let heightHalf = geometry.size.height / 2
            ZStack {
                Group {
                    HotWord("刷轻啦", paddingH: 8, paddingV: 8)
                        .offset(x: widthHalf * 0.6, y: -heightHalf * 0.64)
                    HotWord("外左上", paddingH: 8, paddingV: 8)
                        .offset(x: -widthHalf * 0.5, y: -heightHalf * 0.52)
                    HotWord("内右上", paddingH: 10, paddingV: 10)
                        .offset(x: widthHalf * 0.17, y: -heightHalf * 0.08)
                    HotWord("再用点劲", paddingH: 7, paddingV: 7)
                        .offset(x: -widthHalf * 0.5, y: heightHalf * 0.36)
                    HotWord("外左上", paddingH: 8, paddingV: 8)
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
        }),
        AnyView(SectionResultView(section: "外左上片区", point0: "可以再用点劲", point1: "时长还可以再增加一些哦！")),
        AnyView(SectionResultView(section: "内右下片区", point0: "可以再用点劲", point1: "时长还可以再增加一些哦！")),
    ]

    var body: some View {
        Pager(page: .first(),
              data: pages.indices,
              id: \.self,
              content: { index in
                  pages[index]
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
    var point0: String
    var point1: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(0xDAFDEE))
                    .frame(width: 8, height: 60)
                    .padding(.leading, 2)
                VStack(alignment: .leading, spacing: 3) {
                    Text(section)
                        .fontWeight(.bold)
                    HStack {
                        Circle()
                            .frame(width: 5, height: 5)
                        Text(point0)
                            .font(.caption2)
                    }.foregroundColor(.fontGray)
                    HStack {
                        Circle()
                            .frame(width: 5, height: 5)
                        Text(point1)
                            .font(.caption2)
                    }.foregroundColor(.fontGray)
                }
            }
            Spacer()
            CircularProgressView(score: 82, foregroundColors: [Color.primary], lineWidth: 10, radius: 30)
            Spacer()
            HStack {
                Spacer()
                Image("ResultIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text(section)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
            }

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
