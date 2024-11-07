//
//  ParticleRushView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI

struct AmazingSplashScreenView: View {
    var body: some View {
        ZStack {
            FlowingGradientBackground()
            ParticleShimmer()
            
            VStack {
                Text("KnowledgeHub")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
                    .overlay(PulsingGlow(), alignment: .center)
            }
            .multilineTextAlignment(.center)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Flowing Gradient Background

struct FlowingGradientBackground: View {
    @State private var startPoint = UnitPoint.topLeading
    @State private var endPoint = UnitPoint.bottomTrailing

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black, .purple.opacity(0.5), .black]),
            startPoint: startPoint,
            endPoint: endPoint
        )
        .animation(
            Animation.linear(duration: 6).repeatForever(autoreverses: true),
            value: startPoint
        )
        .onAppear {
            startPoint = UnitPoint.bottomTrailing
            endPoint = UnitPoint.topLeading
        }
        .ignoresSafeArea()
    }
}

// MARK: - Pulsing Glow Effect

struct PulsingGlow: View {
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.5

    var body: some View {
        Circle()
            .fill(Color.purple.opacity(0.7))
            .frame(width: 150, height: 150)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    scale = 1.5
                    opacity = 0.2
                }
            }
    }
}

// MARK: - Particle Shimmer

struct ParticleShimmer: View {
    var body: some View {
        ZStack {
            ForEach(0..<20, id: \.self) { _ in
                ShimmerParticle()
            }
        }
    }
}

struct ShimmerParticle: View {
    @State private var position = ShimmerParticle.randomPosition()
    @State private var opacity: Double = 0.0
    @State private var size: CGFloat = CGFloat.random(in: 3...6)

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: size, height: size)
            .position(position)
            .opacity(opacity)
            .onAppear {
                let animation = Animation.easeInOut(duration: Double.random(in: 1...2))
                    .repeatForever(autoreverses: true)
                
                withAnimation(animation) {
                    opacity = Double.random(in: 0.3...0.8)
                }
            }
    }
    
    static func randomPosition() -> CGPoint {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let randomX = CGFloat.random(in: screenWidth * 0.25...screenWidth * 0.75)
        let randomY = CGFloat.random(in: screenHeight * 0.25...screenHeight * 0.75)
        
        return CGPoint(x: randomX, y: randomY)
    }
}

// MARK: - Preview

struct AmazingSplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        AmazingSplashScreenView()
    }
}




