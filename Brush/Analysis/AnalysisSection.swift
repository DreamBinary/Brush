//
//  AnalysisSection.swift
//  Brush
//
//  Created by cxq on 2023/8/25.
//

import Foundation

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct AnalysisSection: ReducerProtocol {
    struct State: Equatable {
        var topScore: Int = 0
        var avgPower: Double = 0
        var hasData: Bool = false
        var scoreList: [ScorePoint] = []
        var curMonth: Int = Date().monthNum()
        @BindingState var isShowMothly = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case showMonthly
        case getData
        case getDateCompleted([ScorePoint])
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .showMonthly:
                    state.isShowMothly = true
                    state.hasData = false
                    state.scoreList = []
                    return Effect.send(.getData)
                case .getData:
                    if let userId = DataUtil.getUser()?.id {
                        return .task { [month = state.curMonth] in
                            let date = "\(Date().yearNum())-\(month)-1"
                            let response: Response<[String: [ScorePoint]]?> = try await ApiClient.request(Url.totalScore + "/\(userId)" + "/\(date)", method: .GET)
                            if response.code == 200 {
                                let scoreList: [ScorePoint] = response.data!!["totalScoreList"] ?? []
                                return .getDateCompleted(scoreList)
                            }
                            return .getDateCompleted([])
                        }
                    } else {
                        return Effect.send(.getDateCompleted([]))
                    }
                case let .getDateCompleted(list):
                    state.scoreList = list
                    state.hasData = true
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct AnalysisSectionView: View {
    let store: StoreOf<AnalysisSection>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            GeometryReader { geo in
                let height = geo.size.height - 15
                HStack(alignment: .top, spacing: 15) {
                    VStack(spacing: 15) {
                        Top(score: vStore.topScore).frame(height: height*0.4)
                        Mothly().frame(height: height*0.6).onTapGesture {
                            vStore.send(.showMonthly)
                        }
                    }
                    VStack(spacing: 15) {
                        Average(avgPower: vStore.avgPower).frame(height: height*0.25)
                        Conclusion().frame(height: height*0.75)
                    }
                }
            }.padding(.horizontal)
                .sheet(isPresented: vStore.binding(\.$isShowMothly)) {
                    Group {
                        if !vStore.hasData {
                            ProgressView()
                                .frame(width: .infinity, height: .infinity)
                            
                        } else if (vStore.scoreList.isEmpty){
                            Text("空")
                                .frame(width: .infinity, height: .infinity)
                            // TODO
                        } else {
                            RatingLine(scoreList: vStore.scoreList)
                        }
                    }.presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)

//                    //                    if #available(iOS 16.4, *) {
//                    //                        RatingLine()
//                    //                            .presentationDetents([.fraction(0.6)])
//                    //                            .presentationDragIndicator(.visible)
//                    //                            .presentationCornerRadius(30)
//                    //                    } else {
//                    RatingLine()
//                        .presentationDetents([.fraction(0.6)])
//                        .presentationDragIndicator(.visible)
//                    //                    }
                }
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct AnalysisSectionView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisSectionView(
            store: Store(
                initialState: AnalysisSection.State(),
                reducer: AnalysisSection()
            )
        )
    }
}
#endif
