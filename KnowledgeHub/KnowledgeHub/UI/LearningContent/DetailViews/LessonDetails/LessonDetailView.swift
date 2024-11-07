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
            
            // Primary Action Buttons Row
            HStack(spacing: 20) {
                IconButton(iconName: "book.circle.fill", title: "Read") {
                    viewModel.navigateToReadLesson()
                }
                
                IconButton(iconName: "bolt.circle.fill", title: viewModel.learningContentMetadataViewModel.isLesson ? "Flashcard" : "Flashcards") {
                    viewModel.navigateToFlashcards()
                }
                
                IconButton(iconName: "questionmark.circle.fill", title: "Quiz") {
                    viewModel.navigateToQuiz()
                }
            }
            .padding(.vertical, 16)
            
            Spacer()
            
            // Bottom Navigation Bar with Icon-Only Buttons
            HStack {
                Button(action: viewModel.navigateToPreviousLesson) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.titleGold)
                }
                
                Spacer()
                
                Button(action: viewModel.navigateToNextLesson) {
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(.titleGold)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .background(Color.deeperPurple.opacity(0.7).edgesIgnoringSafeArea(.bottom))
        }
    }
}

// Simple icon-only button with optional label
struct IconButton: View {
    let iconName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.titleGold)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.titleGold)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView(
            learningContentMetadataViewModel: LearningContentMetadataViewModel(content: Testing.testLesson),
            viewModel: LessonDetailsViewModel(lesson: Testing.testLesson)
        )
        .background(ThemeConstants.verticalGradient.edgesIgnoringSafeArea(.all))
    }
}
