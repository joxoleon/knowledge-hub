//
//  ContentView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import KHBusinessLogic

struct ContentView: View {
    @StateObject private var splashScreenViewModel = SplashScreenViewModel(contentProvider: KHDomainContentProvider())
    
    var body: some View {
        Group {
            if splashScreenViewModel.proceedToNextScreen {
                MainTabView(viewModel: MainTabViewModel(contentProvider: splashScreenViewModel.contentProvider))
            } else {
                SplashScreenView()
            }
        }
        .environmentObject(splashScreenViewModel)
    }
}

