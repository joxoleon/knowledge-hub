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

    init() {
        let cm = ColorManager(colorTheme: .midnightBlue)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(cm.theme.backgroundColor)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white // For back button and icon colors
    }

    var body: some View {
        NavigationView {
            ZStack {
                colorManager.theme.backgroundColor
                    .edgesIgnoringSafeArea(.all) // Ensures background color covers full screen
                
                let quizViewModel = QuizViewModel(quiz: Testing.testQuiz)
                
                QuizView(viewModel: quizViewModel)
                    .environmentObject(colorManager)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Consistent style for different devices
    }
}

// SwiftUI Preview
#Preview {
    ContentView()
        .environmentObject(ColorManager(colorTheme: .midnightBlue))
        .modelContainer(for: Item.self, inMemory: true)
}
