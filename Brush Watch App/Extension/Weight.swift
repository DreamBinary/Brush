//
//  weight.swift
//  Brush
//
//  Created by cxq on 2023/7/18.
//

import Foundation
import SwiftUI


class WeightProxy {
    let kind: Kind // differentiates between HStack and VStack
    var geo: GeometryProxy? = nil // wrapped GeometryProxy
    private(set) var totalWeight: CGFloat = 0
    
    init(kind: Kind) {
        self.kind = kind
    }
    
    func register(with weight: CGFloat) {
        totalWeight += weight
    }
    
    func dimensionForRelative(weight: CGFloat) -> CGFloat {
        guard let geo = geo,
              totalWeight > 0
        else {
            return 0
        }
        let dimension = (kind == .vertical) ? geo.size.height : geo.size.width
        return dimension * weight / totalWeight
    }
    
    enum Kind {
        case vertical, horizontal
    }
}

struct Weight: ViewModifier {
    private let weight: CGFloat
    private let proxy: WeightProxy
    
    init(_ weight: CGFloat, proxy: WeightProxy) {
        self.weight = weight
        self.proxy = proxy
        proxy.register(with: weight)
    }
    
    @ViewBuilder func body(content: Content) -> some View {
        if proxy.kind == .vertical {
            content.frame(height: proxy.dimensionForRelative(weight: weight))
        } else {
            content.frame(width: proxy.dimensionForRelative(weight: weight))
        }
    }
}

extension View {
    func weight(_ weight: CGFloat, proxy: WeightProxy) -> some View {
        self.modifier(Weight(weight, proxy: proxy))
    }
}


struct WeightHStack<Content>: View where Content : View {
    private let proxy = WeightProxy(kind: .horizontal)
    @State private var initialized = false
    @ViewBuilder let content: (WeightProxy) -> Content
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                if initialized {
                    content(proxy)
                } else {
                    Color.clear.onAppear {
                        proxy.geo = geo
                        initialized.toggle()
                    }
                }
            }
        }
    }
}

struct WeightVStack<Content>: View where Content : View {
    private let proxy = WeightProxy(kind: .vertical)
    @State private var initialized = false
    @ViewBuilder let content: (WeightProxy) -> Content
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                if initialized {
                    content(proxy)
                } else {
                    Color.clear.onAppear {
                        proxy.geo = geo
                        initialized.toggle()
                    }
                }
            }
        }
    }
}


//var body: some View {
//    WeightVStack { proxy in
//        Text("20%")
//            .frame(minWidth: 0, maxWidth: .infinity)
//            .weight(2, proxy: proxy)
//            .background(Color.green)
//        Text("50%")
//            .frame(minWidth: 0, maxWidth: .infinity)
//            .weight(5, proxy: proxy)
//            .background(Color.red)
//        Text("30%")
//            .frame(minWidth: 0, maxWidth: .infinity)
//            .weight(3, proxy: proxy)
//            .background(Color.cyan)
//    }
//    .padding()
//    .foregroundColor(.white)
//    }
