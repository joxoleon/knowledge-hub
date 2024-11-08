
//  BrowseView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

struct MyProgressView: View {
    @ObservedObject var viewModel: MyProgressViewModel
    
    var body: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Track Your Progress")
                    .font(.title)
                    .foregroundColor(.titleGold)
                
                // Additional content here
            }
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

class MyProgressViewModel: ObservableObject {
    // Progress-specific logic and navigation handling here
}
