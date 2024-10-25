//
//  ContentView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var colorManager: ColorManager

    var body: some View {
        let sampleQuiz = QuizImpl.placeholderQuiz
        let quizViewModel = QuizViewModel(quiz: sampleQuiz)
        
        ZStack {
            colorManager.theme.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            QuizView(viewModel: quizViewModel)
                .environmentObject(colorManager)
        }

    }
}

// SwiftUI Preview
#Preview {
    ContentView()
        .environmentObject(ColorManager(colorTheme: .midnightBlue))
        .modelContainer(for: Item.self, inMemory: true)
}


