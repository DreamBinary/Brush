//
//  Popup.swift
//  Brush
//
//  Created by 吕嘻嘻 on 2023/8/18.
//

import SwiftUI
import PopupView


enum ToastType: String {
    case success = "checkmark.circle"
    case fail = "exclamationmark.circle"
}

struct ToastState : Equatable{
    var toastType: ToastType = .success
    var iconColor: Color = .black
    var iconSize : CGFloat = 18
    var text: String = "这是一条提示框"
    var textColor: Color = .black
    var textSize: CGFloat = 16
    var bgColor: Color = .white.opacity(0.8)
    var duration: Double = 1.6
}

extension View {
    func toast(showToast:Binding<Bool>, toastState:ToastState) -> some View {
            self
                .popup(isPresented: showToast) {
                    HStack(spacing: 8) {
                        Image(systemName: toastState.toastType.rawValue)
                            .foregroundColor(toastState.iconColor)
                            .frame(width: toastState.iconSize, height: toastState.iconSize)
                        Text(toastState.text)
                            .foregroundColor(toastState.textColor)
                            .font(.system(size: toastState.textSize))
                    }.padding(16)
                    .background(toastState.bgColor.cornerRadius(12))
                    .background(.ultraThinMaterial)
                    .fixedSize()
                    .padding(.bottom, 50)
                } customize: {
                    $0.type(.floater())
                        .position(.bottom)
                        .appearFrom(.bottom)
                        .animation(.spring())
                        .autohideIn(toastState.duration)
                }
     }
}


struct Shake<Content: View>: View {
    /// Set to true in order to animate
    @Binding var shake: Bool
    /// How many times the content will animate back and forth
    var repeatCount = 3
    /// Duration in seconds
    var duration = 0.8
    /// Range in pixels to go back and forth
    var offsetRange = 10.0

    @ViewBuilder let content: Content
    var onCompletion: (() -> Void)?

    @State private var xOffset = 0.0

    var body: some View {
        content
            .offset(x: xOffset)
            .onChange(of: shake) { shouldShake in
                guard shouldShake else { return }
                Task {
                    await animate()
                    shake = false
                    onCompletion?()
                }
            }
    }

    // Obs: some of factors must be 1.0.
    private func animate() async {
        let factor1 = 0.9
        let eachDuration = duration * factor1 / CGFloat(repeatCount)
        for _ in 0..<repeatCount {
            await backAndForthAnimation(duration: eachDuration, offset: offsetRange)
        }

        let factor2 = 0.1
        await animate(duration: duration * factor2) {
            xOffset = 0.0
        }
    }

    private func backAndForthAnimation(duration: CGFloat, offset: CGFloat) async {
        let halfDuration = duration / 2
        await animate(duration: halfDuration) {
            self.xOffset = offset
        }

        await animate(duration: halfDuration) {
            self.xOffset = -offset
        }
    }
}

extension View {
    func shake(_ shake: Binding<Bool>,
               repeatCount: Int = 3,
               duration: CGFloat = 0.6,
               offsetRange: CGFloat = 10,
               onCompletion: (() -> Void)? = nil) -> some View {
        Shake(shake: shake,
              repeatCount: repeatCount,
              duration: duration,
              offsetRange: offsetRange) {
            self
        } onCompletion: {
            onCompletion?()
        }
    }

    func animate(duration: CGFloat, _ execute: @escaping () -> Void) async {
        await withCheckedContinuation { continuation in
            withAnimation(.linear(duration: duration)) {
                execute()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }
}

