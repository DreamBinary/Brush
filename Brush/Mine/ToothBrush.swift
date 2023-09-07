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
        var toothBrush: ToothBrushEntity?
        @BindingState var isShowingAlert = false
        @BindingState var date: Date = .now
        @BindingState var showToast: Bool = false
        var toastState: ToastState = .init()
        var isLoading: Bool = false
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAddBtn
        case onAddCancel
        case onAddConfirm
        case addToothBrush
        case addSuccess(ToothBrushEntity)
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
                    return Effect.send(.addToothBrush)
                case .onAddBtn:
                    state.isShowingAlert = true
                    return .none
                case .addToothBrush:
                    if let userId = DataUtil.getUser()?.id {
                        state.isLoading = true
                        return .task { [date = state.date] in
                            let response: Response<ToothBrushEntity?> = try await ApiClient.request(Url.toothBrush, method: .POST, params: ["userId": "\(userId)", "usageStartTime": date.formattedString()])
                            if response.code == 200 {
                                let toothBrush: ToothBrushEntity = response.data!!
                                return .addSuccess(toothBrush)
                            }
                            return .addFail
                        }
                    }
                    return Effect.send(.addFail)
                case let .addSuccess(toothBrush):
                    state.isLoading = false
                    state.toothBrush = toothBrush
                    state.toastState.text = "成功添加"
                    state.toastState.toastType = .success
                    state.showToast = true
                    return .none

                case .addFail:
                    state.isLoading = false
                    state.toastState.text = "添加失败"
                    state.toastState.toastType = .fail
                    state.showToast = true
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
                    if (vStore.isLoading) {
                        ProgressView()
                    } else if vStore.toothBrush == nil {
                        VStack {
                            Image("ToothBrush0")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: width * 0.6)
                            Text("暂无牙刷")
                        }.frame(width: width, height: geo.size.height)

                    } else {
                        HasToothBrushView(toothBrush: vStore.toothBrush!)
                    }

                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "plus.circle")
                                .padding(.all, 32)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    vStore.send(.onAddBtn)
                                }
                            Spacer()
                        }
                    }

                    if vStore.isShowingAlert {
                        AddToothBrush(
                            hasToothBrush: vStore.toothBrush != nil,
                            width: width * 0.75,
                            selectionDate: vStore.binding(\.$date),
                            onCancel: { vStore.send(.onAddCancel) },
                            onConfirm: { vStore.send(.onAddConfirm) }
                        )
                    }
                }
            }.font(.body)
                .fontWeight(.semibold)
                .foregroundColor(Color.fontBlack)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.49, green: 0.89, blue: 0.82), location: 0.05),
                            Gradient.Stop(color: Color(red: 0.61, green: 0.92, blue: 0.86), location: 0.47),
                            Gradient.Stop(color: Color(red: 0.09, green: 0.76, blue: 0.65), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.55, y: 0.02),
                        endPoint: UnitPoint(x: 0.98, y: 1)
                    )
                )
                .toast(showToast: vStore.binding(\.$showToast), toastState: vStore.toastState)
        }
    }
}

struct HasToothBrushView: View {
    let toothBrush: ToothBrushEntity
    var body: some View {
        let percent = Double(toothBrush.daysUsed) / Double(toothBrush.daysUsed + toothBrush.daysRemaining)
        GeometryReader { geo in
            let width = geo.size.width
            VStack {
                Spacer()
                Image("ToothBrush1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.1), location: 0),
                                .init(color: Color.white.opacity(0.3), location: percent),
                                .init(color: Color.white.opacity(1), location: 1),
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: width * 0.7)
                    .padding(.bottom)

                HStack(spacing: 0) {
                    Spacer()
                    Text("已使用: \(toothBrush.daysUsed)")
                    Spacer()
                    Text("还剩余: \(toothBrush.daysRemaining)")
                    Spacer()
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: Color.white.opacity(0.1), location: 0),
                        .init(color: Color.white.opacity(0.3), location: percent),
                        .init(color: Color.white.opacity(1), location: 1),
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing).cornerRadius(30)
                )

                Spacer()
            }.padding(.horizontal, 32)
        }
    }
}

struct ToothBrushProgressViewStyle: ProgressViewStyle {
    let width: Double
    let height: Double
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: width, height: height)
                .foregroundColor(Color(0x92D3F5))
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * width, height: height)
                .foregroundColor(.white)
        }
        .padding()
    }
}

// struct ToothBrushBg: View {
//
//    var body: some View {
//        GeometryReader { geo in
//            let width = geo.size.width
//            let height = geo.size.height
//            ZStack {
//                Image("ToothBrush0")
//                    .offset(x: width / 3, y: height / 4)
//
//                Image("ToothBrush1")
//                    .offset(x: -width / 3, y: -height / 4)
//            }.frame(maxWidth: .infinity, maxHeight: .infinity)
//
//
//        }
//
//
//    }
// }

// struct ToothBrushList: View {
//    var toothBrushs: [ToothBrushEntity]
//    var onAddBtn: () -> Void
//    var body: some View {
//        List {
//            ForEach(toothBrushs) { _ in
//                HStack {
//                    Text("sa df g")
//                    Spacer()
//                    Text("sdaf")
//                }
//            }
//            HStack {
//                Spacer()
//                Button(action: {
//                    onAddBtn()
//                }, label: {
//                    Image(systemName: "plus")
//                })
//                Spacer()
//            }
//        }
//    }
// }

struct AddToothBrush: View {
    var hasToothBrush: Bool
    var width: Double
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
                    Text(hasToothBrush ? "更换牙刷" : "添加牙刷")
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
