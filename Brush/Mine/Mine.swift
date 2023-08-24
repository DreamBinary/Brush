//
//  Mine.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Mine: ReducerProtocol {
    struct State: Equatable {
        @BindingState var isShowToothBrush: Bool
        @BindingState var isShowBrushCase: Bool
        var name: String
        var label: String
        var toothBrushDay: Int
        var joinDay: Int
        var brushCase: BrushCase.State

        init(isShowToothBrush: Bool = false,
             isShowBrushCase: Bool = false,
             name: String = DataUtil.getUser()?.username ?? "Worsh",
             label: String = DataUtil.getUser()?.signature ?? "I want BRIGHT smile",
             toothBrushDay: Int = 0,
             joinDay: Int = Date().away(from: Date(timeIntervalSince1970: 1692530488)), // TODO:
             brushCase: BrushCase.State = BrushCase.State())
        {
            self.isShowToothBrush = isShowToothBrush
            self.isShowBrushCase = isShowBrushCase
            self.name = name
            self.label = label
            self.toothBrushDay = toothBrushDay
            self.joinDay = joinDay
            self.brushCase = brushCase
        }
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case brushCase(BrushCase.Action)
        case showToothBrush
        case showBrushCase
        case getDay
        case setDay(Int)
        case logout
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.brushCase, action: /Action.brushCase) { BrushCase() }
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .getDay:
//                    if let userId = DataUtil.getUser()?.id {
                    return .task {
                        let userid = 10031
                        let response: Response<ToothBrushEntity?> = try await ApiClient.request(Url.toothBrush + "/\(userid)", method: .GET)
                        if response.code == 200 {
                            let toothBrush: ToothBrushEntity = response.data!!
                            return .setDay(toothBrush.daysUsed)
                        }
                        return .setDay(90)
                    }
//                    } else {
//                        return Effect.send(.setDay(0))
//                    }

                case let .setDay(day):
                    state.toothBrushDay = day
                    return .none

                case .showToothBrush:
                    state.isShowToothBrush = true
                    return .none
                case .showBrushCase:
                    state.isShowBrushCase = true
                    return .none
                case .logout:
                    DataUtil.removeAll()
                    return .none
                case .binding, .brushCase:
                    return .none
            }
        }
    }
}

// MARK: - Feature view

struct MineView: View {
    let store: StoreOf<Mine>
    @State private var offset: CGPoint = .zero
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { vStore in
            GeometryReader { geo in
                let height = geo.size.height
                let width = geo.size.width
                let initContenHeight = height * 0.75
                let avatarWidth = width * 0.5
                ZStack(alignment: .center) {
                    BackGround(whiteHeight: initContenHeight + offset.y)
                    OffsetObservingScrollView(offset: $offset) {
                        VStack {
                            Spacer(minLength: avatarWidth * sqrt(6) / 4)
                            VStack {
                                VStack(spacing: 5) {
                                    NavigationLink(destination: SettingView(
                                        store: Store(
                                            initialState: Setting.State(),
                                            reducer: Setting()
                                        )
                                    )) {
                                        Text(vStore.name)
                                            .foregroundColor(.fontBlack)
                                            .font(.largeTitle.bold())
                                    }
                                    Text(vStore.label)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.fontGray)

                                    JoinDay(day: vStore.joinDay)

                                    HStack(spacing: 15) {
                                        BrushCaseCard(score:
                                            Int((vStore.brushCase.powerScore + vStore.brushCase.timeScore + vStore.brushCase.sectionScore) / 3)
                                        ).onTapGesture {
                                            vStore.send(.showBrushCase)
                                        }
                                        ToothBrushCard(day: vStore.toothBrushDay).onTapGesture {
                                            vStore.send(.showToothBrush)
                                        }
                                    }.foregroundColor(Color(0x35444C))
                                        .fontWeight(.semibold)
                                        .padding()
                                }.frame(height: initContenHeight - width * 0.5 * sqrt(6) / 4)
                                Button(action: {
                                    vStore.send(.logout)
                                }, label: {
                                    Text("退出当前帐号")
                                        .fontWeight(.medium)
                                        .padding(.vertical, 12)
                                }).buttonStyle(RoundedAndShadowButtonStyle(foregroundColor: Color(0x606060), backgroundColor: Color(0xA5A5A5, 0.14), cornerRadius: 10))
                                    .frame(width: width * 0.7, height: width * 0.1)
                            }
                        }
                    }.padding(.top, height - initContenHeight)
                    MineAvatar(avatarWidth: avatarWidth, degrees: offset.y * 30 / (width * 0.1) - 15.0).offset(y: -height * 0.25 - offset.y)
                }.frame(width: width, height: height)
            }.sheet(isPresented: vStore.binding(\.$isShowBrushCase)) {
                BrushCaseView(
                    store: store.scope(state: \.brushCase, action: Mine.Action.brushCase)
                ).presentationDragIndicator(.visible)
            }.sheet(isPresented: vStore.binding(\.$isShowToothBrush)) {
                ToothBrushView(
                    store: Store(
                        initialState: ToothBrush.State(),
                        reducer: ToothBrush()
                    )
                ).presentationDragIndicator(.visible)
            }.onAppear {
                vStore.send(.getDay)
            }
        }
    }
}

struct BackGround: View {
    var whiteHeight: Double
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.bgWhite)
                .cornerRadius(corners: [.topLeft, .topRight], radius: 16)
                .frame(height: whiteHeight)
                .shadow(radius: 2)
        }.background(
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
    }
}

struct MineAvatar: View {
    var avatarWidth: Double
    var degrees: Double

    init(avatarWidth: Double, degrees: Double) {
        self.avatarWidth = avatarWidth
        if degrees > 15 {
            self.degrees = 15
        } else if degrees < -15 {
            self.degrees = -15
        } else {
            self.degrees = degrees
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: avatarWidth, height: avatarWidth)
                .foregroundColor(Color(0xA9C1FD))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0), radius: 14.5, x: 48, y: -93)
                .shadow(color: .black.opacity(0.01), radius: 13.5, x: 31, y: -59)
                .shadow(color: .black.opacity(0.05), radius: 11.5, x: 17, y: -33)
                .shadow(color: .black.opacity(0.09), radius: 8.5, x: 8, y: -15)
                .shadow(color: .black.opacity(0.1), radius: 4.5, x: 2, y: -4)
                .shadow(color: .black.opacity(0.1), radius: 0, x: 0, y: 0)
                .rotationEffect(Angle(degrees: degrees))
            Avatar(radius: avatarWidth / 2.5, fillColor: Color(0xB5EEC4))
        }
    }
}

struct JoinDay: View {
    var day: Int
    @State private var value = 0
    var body: some View {
        VStack {
            AnimNum(num: day, changeNum: $value) {
                TwoWord("\(value)", "天").padding(.top)
            }

            Text("加入 TuneBrush")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.fontGray)
        }
    }
}

struct BrushCaseCard: View {
    var score: Int
    @State private var value: Int = 0
    var body: some View {
        Card(color: Color(0xA9C1FD)) {
            ZStack(alignment: .bottomLeading) {
                Image("Cavity")
                    .resizable()
                    .scaledToFit()
                    .padding()
                VStack(alignment: .leading) {
                    AnimNum(num: score, changeNum: $value) {
                        TwoWord("\(value)", "分")
                    }
                    Text("查看刷牙情况")
                        .font(.title2)
                }.padding(.horizontal)
            }
        }
    }
}

struct ToothBrushCard: View {
    var day: Int
    @State private var value = 0
    let notify = NotifyUtil()
    var body: some View {
        Card(color: Color(0xA9FDC0)) {
            ZStack(alignment: .bottomLeading) {
                Image("ToothXraySpot")
                    .resizable()
                    .scaledToFit()
                    .padding()
                VStack(alignment: .leading) {
                    AnimNum(num: day, changeNum: $value) {
                        TwoWord("\(value)", "天")
                    }
                    Text("牙刷更换情况")
                        .font(.title2)
                }.padding(.horizontal)
            }
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView(
            store: Store(
                initialState: Mine.State(),
                reducer: Mine()
            )
        )
    }
}
#endif
