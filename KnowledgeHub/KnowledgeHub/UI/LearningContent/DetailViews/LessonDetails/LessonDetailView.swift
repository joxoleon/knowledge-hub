//
//  LessonDetailView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

struct LessonDetailView: View {
    @ObservedObject var learningContentMetadataViewModel: LearningContentMetadataViewModel
    @ObservedObject var viewModel: LessonDetailsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Metadata View at the top
            LearningContentMetadataView(viewModel: learningContentMetadataViewModel)
                .padding(.horizontal)
                .padding(.top, 20)

            // Primary Actions Row
            HStack(spacing: 20) {
                KHButtonView(
                    state: .constant(.active),
                    iconName: "book.circle.fill",
                    title: "Read",
                    titleFont: .system(size: 12),
                    onSelected: viewModel.navigateToReadLesson
                )
                
                KHButtonView(
                    state: .constant(.active),
                    iconName: "bolt.circle.fill",
                    title: viewModel.learningContentMetadataViewModel.isLesson ? "Flashcard" : "Flashcards",
                    titleFont: .system(size: 12),
                    onSelected: viewModel.navigateToFlashcards
                )
                
                KHButtonView(
                    state: .constant(.active),
                    iconName: "questionmark.circle.fill",
                    title: "Quiz",
                    titleFont: .system(size: 12),
                    onSelected: viewModel.navigateToQuiz
                )
            }
            .padding(.horizontal)
            
            // Navigation Row at the Bottom
            HStack(spacing: 40) {
                KHButtonView(
                    state: .constant(.active),
                    iconName: "arrow.left.circle.fill",
                    title: "Previous Lesson",
                    titleFont: .system(size: 12),
                    onSelected: viewModel.navigateToPreviousLesson
                )
                
                Spacer()
                
                KHButtonView(
                    state: .constant(.active),
                    iconName: "arrow.right.circle.fill",
                    title: "Next Lesson",
                    titleFont: .system(size: 12),
                    onSelected: viewModel.navigateToNextLesson
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(ThemeConstants.verticalGradient.edgesIgnoringSafeArea(.all))
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView(
            learningContentMetadataViewModel: LearningContentMetadataViewModel(content: Testing.testLesson),
            viewModel: LessonDetailsViewModel(lesson: Testing.testLesson)
        )
    }
}
