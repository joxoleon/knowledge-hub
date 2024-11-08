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
    @ObservedObject var viewModel: LessonDetailsViewModel
    
    @State private var isReadLessonPresented = false
    @State private var isQuizPresented = false
    @State private var isFlashcardsPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    // Metadata View
                    LearningContentMetadataView(viewModel: viewModel.learningContentMetadataViewModel)
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
                            isFlashcardsPresented = true
                        }
                        
                        Spacer()
                        
                        KHActionButton(
                            iconName: "book.circle.fill",
                            iconSize: Constants.primaryIconSize,
                            title: "Read",
                            fontColor: .titleGold
                        ) {
                            isReadLessonPresented = true
                        }
                        .offset(y: -Constants.primaryIconSize * 1.1)
                        
                        Spacer()
                        
                        KHActionButton(
                            iconName: "questionmark.circle.fill",
                            iconSize: Constants.regularIconSize,
                            title: "Quiz",
                            fontColor: .titleGold
                        ) {
                            isQuizPresented = true
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
                    .padding(.bottom, 30)
                    .padding(.horizontal, 50)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .frame(minHeight: geometry.size.height) // Ensures content stretches to full height
            }
            .background(ThemeConstants.verticalGradient.ignoresSafeArea())
            .fullScreenCover(isPresented: $isReadLessonPresented) {
                viewModel.readLessonView(isPresented: $isReadLessonPresented)
            }
            .fullScreenCover(isPresented: $isQuizPresented) {
                viewModel.quizView(isPresented: $isQuizPresented)
            }
            .fullScreenCover(isPresented: $isFlashcardsPresented) {
                viewModel.flashCardsView(isPresented: $isFlashcardsPresented)
            }
            .onChange(of: isReadLessonPresented) { _, newValue in
                if !newValue { viewModel.refreshValues() }
            }
            .onChange(of: isQuizPresented) { _, newValue in
                if !newValue { viewModel.refreshValues() }
            }
            .onAppear {
                viewModel.refreshValues()
            }
        }
    }
}

enum KHActionButtonState {
    case active
    case disabled
}

struct KHActionButton: View {
    // State property
    @Binding var state: KHActionButtonState
    let iconName: String
    let iconSize: CGFloat
    let title: String
    let fontColor: Color
    let action: (() -> Void)?
    
    init(
        state: Binding<KHActionButtonState> = .constant(.active),
        iconName: String,
        iconSize: CGFloat,
        title: String,
        fontColor: Color,
        action: (() -> Void)?) {
        self._state = state
        self.iconName = iconName
        self.title = title
        self.iconSize = iconSize
        self.action = action
        self.fontColor = fontColor
    }
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(size: self.iconSize))
                    .foregroundColor(state == .active ? .titleGold : .placeholderGray)
                    .shadow(color: .titleGold.opacity(state == .active ? 0.4 : 0.0), radius: self.iconSize / 6)
                
                Text(title)
                    .font(.system(size: iconSize / 4))
                    .fontWeight(.bold)
                    .foregroundColor(state == .active ? .titleGold : .placeholderGray)
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
                viewModel: LessonDetailsViewModel(lesson: Testing.testLesson, mainTabViewModel: nil)
            )
        }
    }
}
