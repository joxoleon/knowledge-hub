//
//  SplashScreen.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI
import KHBusinessLogic

// MARK: - SplashScreenViewModel

class SplashScreenViewModel: ObservableObject {
    @Published var proceedToNextScreen = false
    var isContentInitialized = false
    var hasInitialized = false
    var contentProvider: any KHDomainContentProviderProtocol
    
    init(contentProvider: any KHDomainContentProviderProtocol) {
        self.contentProvider = contentProvider
    }
    
    func initializeContent() async {
        guard !hasInitialized else { return }
        hasInitialized = true
        
        print("*** ViewModel: Initializing Content ***")
        try? await contentProvider.initializeContent()
        DispatchQueue.main.async {
            self.isContentInitialized = true
            self.checkIfReadyToProceed()
        }
    }
    
    func checkIfReadyToProceed() {
        // Check if both conditions (content and animations) are met
        if isContentInitialized && animationCompleted && fadeOutCompleted {
            proceedToNextScreen = true
        }
    }
    
    // Track animation completion and fade-out completion
    @Published var animationCompleted = false {
        didSet {
            if animationCompleted {
                checkIfReadyToProceed()
            }
        }
    }
    
    @Published var fadeOutCompleted = false {
        didSet {
            if fadeOutCompleted {
                checkIfReadyToProceed()
            }
        }
    }
}

struct SplashScreenView: View {
    @EnvironmentObject private var viewModel: SplashScreenViewModel
    @State private var textOpacity = 1.0

    var body: some View {
        ZStack {
            // Background Gradient
            ThemeConstants.verticalGradient
                .ignoresSafeArea()

            // Flip Animation View with Opacity for Fade-Out
            FlipTextSplashView(animationDuration: 1.0, firstWordFontSize: 36, secondWordFontSize: 72)
                .opacity(textOpacity) // Controlled opacity for fade-out
        }
        .ignoresSafeArea()
        .task {
            await performSplashScreenSequence()
        }
    }

    private func performSplashScreenSequence() async {
        // Run both the animation wait and content initialization in parallel
        async let animationWait: () = waitForAnimationCompletion()
        async let contentInitialization: () = viewModel.initializeContent()
        
        // Wait for both to complete
        _ = await (animationWait, contentInitialization)
        
        // Start the fade-out animation after the flip is complete and pause
        await startFadeOutAnimation()
    }
    
    private func waitForAnimationCompletion() async {
        // Total 2-second wait (1.2 seconds for animation + 0.8-second pause)
        try? await Task.sleep(nanoseconds: UInt64(1.5 * 1_000_000_000))
        
        // Mark animation as completed
        DispatchQueue.main.async {
            viewModel.animationCompleted = true
        }
    }
    
    private func startFadeOutAnimation() async {
        // Fade out over 1.2 seconds
        await MainActor.run {
            withAnimation(.easeOut(duration: 1.2)) {
                textOpacity = 0.0
            }
        }
        
        // Wait for fade-out to complete
        try? await Task.sleep(nanoseconds: UInt64(1.2 * 1_000_000_000))
        
        // Mark fade-out as completed
        DispatchQueue.main.async {
            viewModel.fadeOutCompleted = true
        }
    }
}

// MARK: - Preview

struct SplashScreenView_Preview: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .environmentObject(SplashScreenViewModel(contentProvider: Testing.contentProvider))
    }
}
