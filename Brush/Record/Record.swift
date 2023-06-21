//
//  Record.swift
//  Brush
//
//  Created by cxq on 2023/6/21.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain

struct Record: ReducerProtocol {
    struct State: Equatable {
//        @BindingState var
    }
    
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

struct RecordView: View {
    let store: StoreOf<Record>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
        
            ScrollView {
                VStack {
                    
                    Card(color: Color(0xDDC0F9), height: 200) {
                        VStack {
                            Text("历史最高分")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("98")
                                .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("月度最高Top")
                                .font(.callout)
                        }
                    }
                    
                    Card(color: Color(0xDDC0F9), height: 200) {
                        VStack {
                            Text("历史最高分")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("98")
                                .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("月度最高Top")
                                .font(.callout)
                        }
                    }
                    Card(color: Color( 0xDDC0F9), height: 200) {
                        VStack {
                            Text("历史最高分")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("98")
                                .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("月度最高Top")
                                .font(.callout)
                        }
                    }
                    
                    Card(color: Color( 0xDDC0F9), height: 200) {
                        VStack {
                            Text("历史最高分")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("98")
                                .font(.system(size: UIFont.textStyleSize(.largeTitle) * 2))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("月度最高Top")
                                .font(.callout)
                        }
                    }
                    
                    //                Card(color: Color(0xDDC0F9)) {
                    //                    Text("hello")
                    //                }
                }
            }
            
        }
    }
}

// MARK: - SwiftUI previews

#if DEBUG
struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(
            store: Store(
                initialState: Record.State(),
                reducer: Record()
            )
        )
    }
}
#endif
