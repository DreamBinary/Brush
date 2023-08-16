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
        var toothBrushs: [ToothBrushEntity] = [
            ToothBrushEntity(day: Date(), brushName: "牙刷1"),
            ToothBrushEntity(day: Date(), brushName: "牙刷2"),
            ToothBrushEntity(day: Date(), brushName: "牙刷3"),
            ToothBrushEntity(day: Date(), brushName: "牙刷4"),
            ToothBrushEntity(day: Date(), brushName: "牙刷5"),
            ToothBrushEntity(day: Date(), brushName: "牙刷6"),
            ToothBrushEntity(day: Date(), brushName: "牙刷7"),
            ToothBrushEntity(day: Date(), brushName: "牙刷8"),
            ToothBrushEntity(day: Date(), brushName: "牙刷9"),
            ToothBrushEntity(day: Date(), brushName: "牙刷10"),
            ToothBrushEntity(day: Date(), brushName: "牙刷11"),
            ToothBrushEntity(day: Date(), brushName: "牙刷12"),
            ToothBrushEntity(day: Date(), brushName: "牙刷13"),
        ]
        @BindingState var isShowingAlert = false
        @BindingState var brushName: String = ""
        @BindingState var password: String = ""
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case showAlert
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .showAlert:
                    state.isShowingAlert = true
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct ToothBrushEntity: Identifiable, Equatable {
    let id = UUID()
    let day :Date
    let brushName: String
}

struct ToothBrushView: View {
    let store: StoreOf<ToothBrush>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            List {
                ForEach(vStore.toothBrushs) { item in
                    HStack {
                        Text(item.brushName)
                        Spacer()
                        Text(item.day, style: .date)
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        vStore.send(.showAlert)
                    }, label: {
                        Image(systemName: "plus")
                    })
                    Spacer()
                }
            }.navigationTitle("牙刷更换情况")
//                .alert(isPresented: vStore.binding(\.$isShowingAlert), content: {
//                    VStack {
//                        Text("添加牙刷")
//                        TextField("输入牙刷名字", text: vStore.binding(\.$brushName))
//                    }
//                })
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
