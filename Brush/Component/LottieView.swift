////
////  LottieView.swift
////  Brush
////
////  Created by cxq on 2023/8/28.
////
//
//import SwiftUI
//import Lottie
//
//import Lottie
//import SwiftUI
//
//struct LottieView: UIViewRepresentable {
//    let filename: String
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        
//    }
//    
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        let animationView = LottieAnimationView(name: filename)
//        animationView.loopMode = .loop
//        animationView.contentMode = .scaleAspectFit
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(animationView)
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//        animationView.play()
//        return view
//    }
//}
