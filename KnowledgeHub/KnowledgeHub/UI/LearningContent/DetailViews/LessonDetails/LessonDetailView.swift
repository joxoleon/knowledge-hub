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
        VStack {
            LearningContentMetadataView(viewModel: learningContentMetadataViewModel)
                .padding()
            
            HStack {
                KHButtonView(
                    state: .constant(.active),
                    iconName: "book.circle.fill",
                    title: "Read",
                    titleFont: .system(size: 10),
                    onSelected: {
                        viewModel.navigateToReadLesson()
                    }
                )
                
                KHButtonView(
                    state: .constant(.active),
                    iconName: "bolt.circle.fill",
                    title: viewModel.learningContentMetadataViewModel.isLesson ? "Flashcard" : "Flashcards",
                    titleFont: .system(size: 10),
                    onSelected: {
                        viewModel.navigateToFlashcards()
                    }
                )
                
                KHButtonView(
                    state: .constant(.active),
                    iconName: "questionmark.circle.fill",
                    title: "Quiz",
                    titleFont: .system(size: 10),
                    onSelected: {
                        viewModel.navigateToQuiz()
                    }
                )
            }
            .padding()
            
            HStack(spacing: 35) {
                KHButtonView(
                    state: .constant(.active),
                    iconName: "arrow.left.circle.fill",
                    title: "Previous Lesson",
                    titleFont: .system(size: 10),
                    onSelected: {
                        viewModel.navigateToPreviousLesson()
                    }
                )
                
                Spacer()
                
                KHButtonView(
                    state: .constant(.active),
                    iconName: "arrow.right.circle.fill",
                    title: "Next Lesson",
                    titleFont: .system(size: 10),
                    onSelected: {
                        viewModel.navigateToNextLesson()
                    }
                )
            }
            .padding()
            

        }
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .edgesIgnoringSafeArea(.all)
            
            LessonDetailView(
                learningContentMetadataViewModel: LearningContentMetadataViewModel(content: Testing.testLesson),
                viewModel: LessonDetailsViewModel(lesson: Testing.testLesson)
            )
        }
    }
}
