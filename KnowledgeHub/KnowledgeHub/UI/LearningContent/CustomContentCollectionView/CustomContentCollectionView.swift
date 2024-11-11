// CustomContentCollectionView.swift
// KnowledgeHub
//
// Created by Jovan Radivojsa on 10.11.24.
//

import SwiftUI
import KHBusinessLogic

struct CustomContentCollectionView: View {
    @ObservedObject var viewModel: CustomContentCollectionViewModel

    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text(viewModel.title)
                .font(.title)
                .foregroundColor(.titleGold)
                .padding(.top, 16)
            
            // Description
            Text(viewModel.description)
                .foregroundColor(.titleGold.opacity(0.7))
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            // Action Buttons
            HStack(spacing: 16) {
                KHActionButton(iconName: IconConstants.flashcardsAction, iconSize: 60.0, title: "Flashcards", fontColor: .titleGold, action: viewModel.onFlashcardsTapped)
                KHActionButton(iconName: IconConstants.quizAction, iconSize: 60.0, title: "Quiz", fontColor: .titleGold, action: viewModel.onQuizTapped)
            }
            .padding(.horizontal)
            
            // Learning Content List
            LearningContentsListView(
                viewModel: LearningContentsListViewModel(content: viewModel.contents, showFilterButtons: true)
            )
            .padding(.horizontal)
        }
        .padding(.bottom, 16)
        .background(ThemeConstants.verticalGradient)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - ViewModel
class CustomContentCollectionViewModel: ObservableObject {
    // MARK: - Properties
    let title: String
    let description: String
    let contents: [LearningContent]
    var showFilterButtons: Bool = false

    // MARK: - Actions
    var onFlashcardsTapped: () -> Void
    var onQuizTapped: () -> Void

    // MARK: - Initialization
    init(title: String,
         description: String,
         contents: [LearningContent],
         onFlashcardsTapped: @escaping () -> Void,
         onQuizTapped: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.contents = contents
        self.onFlashcardsTapped = onFlashcardsTapped
        self.onQuizTapped = onQuizTapped
    }
}

// MARK: - Preview
struct CustomContentCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CustomContentCollectionViewModel(
            title: "Custom Collection",
            description: "Explore this curated set of learning content tailored for your study needs.",
            contents: Testing.contentProvider.activeTopModule.preOrderLessons + Testing.contentProvider.activeTopModule.levelOrderModules,
            onFlashcardsTapped: { print("Flashcards tapped") },
            onQuizTapped: { print("Quiz tapped") }
        )
        
        CustomContentCollectionView(viewModel: viewModel)
    }
}
