//
//  Result.swift
//  Brush
//
//  Created by cxq on 2023/6/24.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI
import SwiftUIPager

// MARK: - Feature domain

struct Result: ReducerProtocol {
    struct State: Equatable {}

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

struct ResultView: View {
    let store: StoreOf<Result>

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
        WithViewStore(self.store, observe: { $0 }) { _ in
            ZStack {
                VStack {
                    Spacer()
                    Image("BgBottom")
                }.edgesIgnoringSafeArea(.bottom)

                VStack {
                    HStack {
                        Card(color: Color(0x7DE2D1), width: 50, height: 50, cornerRadius: 10) {
                            BrushIcon(radius: 50).padding(.all, 6)
                        }
                        Spacer().frame(width: 20)
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Text("新的乐曲记录已生成！")
                                    .font(.body.bold())
                                Spacer()
                                Text("34m ago")
                                    .font(.footnote)
                                    .foregroundColor(.fontGray)
                            }
                            Text("快来听听你的全新作品吧~")
                                .font(.footnote)
                                .fontWeight(.medium)
                        }
                    }.padding()
                        .background(Color(0x7DE2D1, 0.38))
                        .cornerRadius(16)
                        .padding()

                    CircularProgressView(score: 90, radius: 100, tip: "你还可以做得更好！")
                        .padding()

                    Card(color: Color(0x7DE2D1), height: 80) {
                        HStack {
                            Spacer().frame(width: 8)
                            Card(color: Color(0xE6F6FF), corners: [.topRight, .bottomRight]) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image("ToothXraySpot")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                        Text("敏感度更新")
                                            .font(.body)
                                            .fontWeight(.medium)
                                        Spacer()
                                    }
                                    Text("若您最近得口腔状况有所不适，请及时告诉我们")
                                        .font(.footnote)
                                        .foregroundColor(.fontGray)
                                }.padding()
                            }.cornerRadius(corners: [.topLeft, .bottomLeft], radius: 10)
                        }
                    }.padding(.horizontal)
                        .shadow(color: .black.opacity(0.04), radius: 0.49133, x: 0, y: 0)
                        .shadow(color: .black.opacity(0.04), radius: 2.948, x: 0, y: 1.96533)
                        .shadow(color: .black.opacity(0.06), radius: 11.792, x: 0, y: 15.72267)

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
                          })
                          .itemAspectRatio(0.7)
                          .interactive(scale: 0.8)
                          .loopPages()
                          .draggingAnimation(.interactive)
                          .frame(height: 260)

                    Spacer()
                }
            }
        }
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
            CircularProgressView(score: 82, lineWidth: 10, radius: 30)
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
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(
            store: Store(
                initialState: Result.State(),
                reducer: Result()
            )
        )
    }
}
#endif
