//
//  AnimatedBackgroundView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI

// MARK: - Pulsating Circles View

struct PulsatingCirclesView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 200, height: 200)
                .scaleEffect(animate ? 1.3 : 1)
                .opacity(animate ? 0 : 1)
                .animation(
                    Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false),
                    value: animate
                )
            
            Circle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 300, height: 300)
                .scaleEffect(animate ? 1.4 : 1)
                .opacity(animate ? 0 : 1)
                .animation(
                    Animation.easeOut(duration: 2).repeatForever(autoreverses: false),
                    value: animate
                )
        }
        .onAppear {
            animate.toggle()
        }
        .ignoresSafeArea()
    }
}

// MARK: - Moving Stars View

struct MovingStarsView: View {
    @State private var animateStars = false
    
    var body: some View {
        ZStack {
            ForEach(0..<50) { _ in
                Circle()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: CGFloat.random(in: 2...3), height: CGFloat.random(in: 2...3))
                    .offset(
                        x: CGFloat.random(in: -200...200),
                        y: CGFloat.random(in: -400...400)
                    )
                    .opacity(animateStars ? 1 : 0.3)
                    .animation(
                        Animation.easeInOut(duration: Double.random(in: 2...4))
                            .repeatForever(autoreverses: true),
                        value: animateStars
                    )
            }
        }
        .onAppear {
            animateStars.toggle()
        }
        .ignoresSafeArea()
    }
}


struct AnimatedBackgroundView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ThemeConstants.verticalGradient
            
            PulsatingCirclesView()
            MovingStarsView()
        }
    }
}


#Preview {
    AnimatedBackgroundView()
        .ignoresSafeArea()
}
