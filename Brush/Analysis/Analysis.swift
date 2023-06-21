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

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack(spacing: 25) {
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
                Card(color: Color(0xE1F5B3)) {
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
                                .padding(.top, 15)
                        }
                        Image("avatar")
                        
                    }
                }
                .frame(height: 150)
                .padding(.horizontal)
                
                
               
            }
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
