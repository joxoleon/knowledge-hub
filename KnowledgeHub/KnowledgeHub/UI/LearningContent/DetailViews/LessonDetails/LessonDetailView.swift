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
        ZStack {
            VStack(spacing: 20) {
                // Metadata View
                LearningContentMetadataView(viewModel: learningContentMetadataViewModel)
                    .padding(.horizontal)
                
                Spacer()

                // Centered Action Buttons Row with Elevated Read Button
                HStack {
                    ActionButton(iconName: "bolt.circle.fill", title: "Flashcard") {
                        viewModel.navigateToFlashcards()
                    }
                    
                    Spacer()

                    ActionButton(iconName: "book.circle.fill", title: "Read", isPrimary: true) {
                        viewModel.navigateToReadLesson()
                    }
                    .offset(y: -45)
                    
                    Spacer()
                    
                    ActionButton(iconName: "questionmark.circle.fill", title: "Quiz") {
                        viewModel.navigateToQuiz()
                    }
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 20)

                Spacer()
                
                // Navigation Buttons at the Bottom
                HStack {
                    NavigationButton(direction: .left) {
                        viewModel.navigateToPreviousLesson()
                    }
                    
                    Spacer()
                    
                    NavigationButton(direction: .right) {
                        viewModel.navigateToNextLesson()
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
        }
        .background(ThemeConstants.verticalGradient.ignoresSafeArea())
    }
}

// MARK: - ActionButton Component with Primary Option
struct ActionButton: View {
    let iconName: String
    let title: String
    let isPrimary: Bool
    let action: () -> Void
    
    init(iconName: String, title: String, isPrimary: Bool = false, action: @escaping () -> Void) {
        self.iconName = iconName
        self.title = title
        self.isPrimary = isPrimary
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(isPrimary ? .system(size: 52) : .system(size: 42))
                    .foregroundColor(.titleGold)
                    .shadow(color: .yellow.opacity(0.4), radius: isPrimary ? 10 : 6, x: 0, y: 0)
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(isPrimary ? .bold : .semibold)
                    .foregroundColor(.titleGold)
            }
        }
        .frame(width: isPrimary ? 80 : 60, height: isPrimary ? 80 : 60)
    }
}

// MARK: - NavigationButton Component with Circle Style
struct NavigationButton: View {
    enum Direction { case left, right }
    
    let direction: Direction
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Circle()
                    .fill(Color.deeperPurple.opacity(0.7))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: direction == .left ? "arrow.left" : "arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(.titleGold)
                    )
                    .shadow(color: .yellow.opacity(0.3), radius: 6, x: 0, y: 0) // Subtle glow for the arrows

                Text(direction == .left ? "Previous" : "Next")
                    .font(.caption)
                    .foregroundColor(.titleGold)
                    .padding(.top, 4)
            }
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
