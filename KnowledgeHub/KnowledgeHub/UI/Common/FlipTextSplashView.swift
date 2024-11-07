//
//  FlipTextSplashView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI

struct FlipTextSplashView: View {
    // Adjustable properties
    private let animationDuration: Double
    private let firstWordFontSize: CGFloat
    private let secondWordFontSize: CGFloat
    
    // Initializer
    init(animationDuration: Double = 1.5, firstWordFontSize: CGFloat = 36, secondWordFontSize: CGFloat = 72) {
        self.animationDuration = animationDuration
        self.firstWordFontSize = firstWordFontSize
        self.secondWordFontSize = secondWordFontSize
    }
    
    var body: some View {
        ZStack {
            // Background Gradient
            ThemeConstants.verticalGradient
                .ignoresSafeArea()

            VStack(spacing: 10) {
                // First Line: "Knowledge"
                HStack(spacing: 0) {
                    ForEach(Array("Knowledge".enumerated()), id: \.offset) { index, letter in
                        FlippingLetterView(
                            letter: String(letter),
                            delay: Double(index) * (animationDuration / 10),
                            duration: animationDuration
                        )
                    }
                }
                .font(.system(size: firstWordFontSize, weight: .bold))
                .foregroundColor(.titleGold)

                // Second Line: "HUB"
                HStack(spacing: 0) {
                    ForEach(Array("HUB".enumerated()), id: \.offset) { index, letter in
                        FlippingLetterView(
                            letter: String(letter),
                            delay: Double(index) * (animationDuration / 5),
                            duration: animationDuration * 1.5
                        )
                    }
                }
                .font(.system(size: secondWordFontSize, weight: .bold))
                .foregroundColor(.titleGold)
            }
            .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Flipping Letter View

struct FlippingLetterView: View {
    let letter: String
    let delay: Double
    let duration: Double
    
    @State private var flipped = false

    var body: some View {
        Text(letter)
            .rotation3DEffect(
                .degrees(flipped ? 0 : -180),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(flipped ? 1 : 0)
            .onAppear {
                withAnimation(Animation.easeOut(duration: duration).delay(delay)) {
                    flipped = true
                }
            }
    }
}

// MARK: - Preview

struct FlipTextSplashView_Previews: PreviewProvider {
    static var previews: some View {
        FlipTextSplashView(animationDuration: 1.2, firstWordFontSize: 36, secondWordFontSize: 72)
    }
}

