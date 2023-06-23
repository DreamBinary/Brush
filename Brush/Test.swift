//
//  Test.swift
//  Brush
//
//  Created by cxq on 2023/6/23.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Test: ReducerProtocol {
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

struct TestView: View {
    let store: StoreOf<Test>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                ZStack {
                    Image("TestBgTop")
                        .cornerRadius(40)
                        .edgesIgnoringSafeArea(.top)
                    Image("ToothXraySpot")
                    VStack(alignment: .leading, spacing: 3) {
                        Text("牙齿敏感度测试")
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("如果您感到牙齿不舒服请告诉我们！")
                            .foregroundColor(.fontGray)
                            .font(.caption2)
                    }.padding(.leading, -120)
                        .padding(.top, 350)
                }.edgesIgnoringSafeArea(.top)
                Card(color: Color(0x7DE2D1, 0.14), height: 250, cornerRadius: 25) {
                    VStack(alignment: .leading) {
                        Text("Finishing")
                            .foregroundColor(Color(0x7DE2D1))
                            .font(.caption2)
                        Text("已完成30%")
                            .foregroundColor(.fontGray)
                            .font(.callout)
                            .fontWeight(.bold)

                        Text("在摄入较冰食物的时候，您是否牙齿感到酸痛难忍")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.vertical, 3)

                        HStack {
                            Spacer()
                            VStack {
                                Rating()
                                Text("请给您感到不适的程度打个分！")
                                    .foregroundColor(.fontGray)
                                    .font(.caption2)
                            }
                            Spacer()
                        }
                    }.padding()
                }.padding()
                Spacer()
                Image("TestBgBottom")
            }
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(
            store: Store(
                initialState: Test.State(),
                reducer: Test()
            )
        )
    }
}
#endif
