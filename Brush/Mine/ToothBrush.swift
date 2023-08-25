//
//  ToothBrushView.swift
//  Brush
//
//  Created by cxq on 2023/8/16.
//

import SwiftUI

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct ToothBrush: ReducerProtocol {
    struct State: Equatable {
        var toothBrushs: [ToothBrushEntity] = []
        @BindingState var isShowingAlert = false
        @BindingState var brushName: String = ""
        @BindingState var date: Date = .now
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAddBtn
        case onAddCancel
        case onAddConfirm
        case addToothBrush
        case addSuccess
        case addFail
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .onAddCancel:
                    state.isShowingAlert = false
                    return .none
                case .onAddConfirm:
                    state.isShowingAlert = false
                    return .none
                case .onAddBtn:
                    state.isShowingAlert = true
                    return .none
                case .addToothBrush:
                    if let userId = DataUtil.getUser()?.id {
                        return .task {
                            let userId = 10031
                            let response: Response<ToothBrushEntity?> = try await ApiClient.request(Url.toothBrush, method: .POST, params: ["userId": "\(userId)", "usageStartTime": "\(Int(Date().timeIntervalSince1970 * 1000))"])
                            if response.code == 200 {
                                let _: ToothBrushEntity = response.data!! //TODO
                                return .addSuccess
                            }
                            return .addFail
                        }
                    }
                    return Effect.send(.addFail)
                case .addSuccess:
                    return .none
                    
                case .addFail:
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct ToothBrushView: View {
    let store: StoreOf<ToothBrush>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            GeometryReader { geo in
                let width = geo.size.width
                ZStack {
                    ToothBrushList(toothBrushs: vStore.toothBrushs, onAddBtn: { vStore.send(.onAddBtn) })

                    if vStore.isShowingAlert {
                        AddToothBrush(
                            width: width * 0.75,
                            text: vStore.binding(\.$brushName),
                            selectionDate: vStore.binding(\.$date),
                            onCancel: { vStore.send(.onAddCancel) },
                            onConfirm: { vStore.send(.onAddConfirm) }
                        )
                    }
                }
            }
        }
    }
}

struct ToothBrushList: View {
    var toothBrushs: [ToothBrushEntity]
    var onAddBtn: () -> Void
    var body: some View {
        List {
            ForEach(toothBrushs) { _ in
                HStack {
                    Text("sa df g")
                    Spacer()
                    Text("sdaf")
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    onAddBtn()
                }, label: {
                    Image(systemName: "plus")
                })
                Spacer()
            }
        }
    }
}

struct AddToothBrush: View {
    var width: Double
    var text: Binding<String>
    var selectionDate: Binding<Date>
    var onCancel: () -> Void
    var onConfirm: () -> Void
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(1)
            ZStack {
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
                    .transition(.scale)
                    .clipShape(RoundedCorners(corners: .allCorners, radius: 10))
                VStack {
                    Text("添加牙刷").font(.title3)
                    HStack {
                        Text("名字").padding(.trailing)
                        TextField("输入牙刷名字", text: text)
                    }
                    HStack {
                        DatePicker(selection: selectionDate, displayedComponents: .date, label: { Text("日期").padding(.trailing) }).fixedSize()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action: onCancel, label: {
                            Text("取消")
                        })
                        Spacer()
                        Button(action: onConfirm, label: {
                            Text("添加")
                        })
                        Spacer()
                    }
                }.padding()
            }.frame(width: width)
                .fixedSize(horizontal: false, vertical: true)
                .zIndex(2)
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct ToothBrushView_Previews: PreviewProvider {
    static var previews: some View {
        ToothBrushView(
            store: Store(
                initialState: ToothBrush.State(),
                reducer: ToothBrush()
            )
        )
    }
}
#endif
