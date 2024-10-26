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
        NavigationView { // Wrap the content in a NavigationView
            let sampleQuiz = QuizImpl.placeholderQuiz
            let quizViewModel = QuizViewModel(quiz: sampleQuiz)
            
            ZStack {
                colorManager.theme.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                // Embed QuizView in a NavigationLink if you want to push it onto the stack from here
                QuizView(viewModel: quizViewModel)
                    .environmentObject(colorManager)
            }
        }
    }
}

// SwiftUI Preview
#Preview {
    ContentView()
        .environmentObject(ColorManager(colorTheme: .midnightBlue))
        .modelContainer(for: Item.self, inMemory: true)
}
