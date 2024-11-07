//
//  LessonDetailView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

fileprivate enum Constants {
    static let primaryIconSize: CGFloat = 65.0
    static let regularIconSize: CGFloat = 50.0
    static let navigationIconSize: CGFloat = 36.0
}

struct LessonDetailView: View {
    @ObservedObject var learningContentMetadataViewModel: LearningContentMetadataViewModel
    @ObservedObject var viewModel: LessonDetailsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Metadata View
                    LearningContentMetadataView(viewModel: learningContentMetadataViewModel)
                        .padding(.vertical)
                    
                    Spacer(minLength: 10)
                    
                    HStack {
                        Spacer()
                        KHActionButton(
                            iconName: "bolt.circle.fill",
                            iconSize: Constants.regularIconSize,
                            title: "Flashcard",
                            fontColor: .titleGold
                        ) {
                            viewModel.navigateToFlashcards()
                        }
                        Spacer()
                        KHActionButton(
                            iconName: "book.circle.fill",
                            iconSize: Constants.primaryIconSize,
                            title: "Read",
                            fontColor: .titleGold
                        ) {
                            viewModel.navigateToReadLesson()
                        }
                        .offset(y: -Constants.primaryIconSize * 1.1)
                        Spacer()
                        KHActionButton(
                            iconName: "questionmark.circle.fill",
                            iconSize: Constants.regularIconSize,
                            title: "Quiz",
                            fontColor: .titleGold
                        ) {
                            viewModel.navigateToQuiz()
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 15)

                    
                    // Bottom Navigation Buttons
                    HStack {
                        KHActionButton(
                            iconName: "arrow.left.circle.fill",
                            iconSize: Constants.navigationIconSize,
                            title: "Previous",
                            fontColor: .titleGold
                        ) {
                            viewModel.navigateToPreviousLesson()
                        }
                        
                        Spacer()
                        
                        KHActionButton(
                            iconName: "arrow.right.circle.fill",
                            iconSize: Constants.navigationIconSize,
                            title: "Next",
                            fontColor: .titleGold
                        ) {
                            viewModel.navigateToNextLesson()
                        }
                    }
                    .padding(.bottom, 12)
                    .padding(.horizontal, 50)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .frame(minHeight: geometry.size.height) // Ensures content stretches to full height
            }
            .background(ThemeConstants.verticalGradient.ignoresSafeArea())
        }
    }
}

// MARK: - Unified Button Component for Both Action and Navigation
struct KHActionButton: View {
    let iconName: String
    let iconSize: CGFloat
    let title: String
    let fontColor: Color
    let action: () -> Void
    
    init(iconName: String, iconSize: CGFloat, title: String, fontColor: Color, action: @escaping () -> Void) {
        self.iconName = iconName
        self.title = title
        self.iconSize = iconSize
        self.action = action
        self.fontColor = fontColor
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(size: self.iconSize))
                    .foregroundColor(.titleGold)
                    .shadow(color: .titleGold.opacity(0.4), radius: self.iconSize / 8)
                
                Text(title)
                    .font(.system(size: iconSize / 5))
                    .fontWeight(.bold)
                    .foregroundColor(.titleGold)
            }
        }
        .frame(width: iconSize * 2, height: iconSize * 2)
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
