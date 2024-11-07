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
    @Published var isInitialized = false
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
            self.isInitialized = true
        }
    }
}

struct SplashScreenView: View {
    @EnvironmentObject private var viewModel: SplashScreenViewModel // Use environmentObject

    @State private var startPoint = UnitPoint.topLeading
    @State private var endPoint = UnitPoint.bottomTrailing

    var body: some View {
        ZStack {
            // Flowing gradient background
            LinearGradient(
                gradient: Gradient(colors: [.black, .deepPurple]),
                startPoint: startPoint,
                endPoint: endPoint
            )
            .animation(
                Animation.linear(duration: 6).repeatForever(autoreverses: true),
                value: startPoint
            )
            .onAppear {
                startPoint = UnitPoint.bottomLeading
                endPoint = UnitPoint.topTrailing
            }

            // Centered Title
            VStack(spacing: 0) {
                Text("Knowledge")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.titleGold)
                    .padding(.bottom, 4)
                
                Text("Hub")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.titleGold)
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .task {
            await viewModel.initializeContent()
        }
    }
}

// MARK: - Preview

#Preview {
    SplashScreenView()
        .environmentObject(SplashScreenViewModel(contentProvider: Testing.contentProvider))
}
