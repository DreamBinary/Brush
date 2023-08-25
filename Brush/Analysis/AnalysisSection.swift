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
        var topScore: Int = 93
        var avgPower: Double = 0.55
        @BindingState var isShowMothly = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case showMonthly
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .showMonthly:
                    state.isShowMothly = true
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
                    //                    if #available(iOS 16.4, *) {
                    //                        RatingLine()
                    //                            .presentationDetents([.fraction(0.6)])
                    //                            .presentationDragIndicator(.visible)
                    //                            .presentationCornerRadius(30)
                    //                    } else {
                    RatingLine()
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                    //                    }
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
