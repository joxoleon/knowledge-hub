//
//  QuizView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 25.10.24..
//

import SwiftUI
import ProgressIndicatorView
import KHBusinessLogic

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State var isReadLessonPresented: Bool = false
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            // Background
            ThemeConstants.verticalGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
            
                    // Question View
                    if let multipleChoiceQuestion = viewModel.currentQuestion as? MultipleChoiceQuestion {
                        MultipleChoiceQuestionView(
                            question: multipleChoiceQuestion,
                            selectedAnswer: $viewModel.selectedAnswer
                        )
                        .padding(.horizontal)
                    }
                    
                    // Progress Section
                    progressSection
                        
                    // Navigation Buttons
                    navigationButtonSection
                        .padding(.top, 4)
                        .padding(.horizontal, 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scrollIndicators(.visible)
                

            }
            .padding(.top, 30)
            .fullScreenCover(isPresented: Binding(
                get: { isReadLessonPresented && viewModel.lessonForCurrentQuestion != nil },
                set: { isReadLessonPresented = $0 }
            )) {
                if let lesson = viewModel.lessonForCurrentQuestion {
                    ReadLessonView(viewModel: LessonViewModel(lesson: lesson), isPresented: $isReadLessonPresented)
                }
            }
            
            // Close Button
            Button(action: {
                isPresented = false
            }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 30))
                    .foregroundColor(.titleGold)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var navigationButtonSection: some View {
        HStack {
            // Read Lesson Button
            KHActionButton(
                state: $viewModel.readLessonButonState,
                iconName: "book.circle.fill",
                iconSize: 60,
                title: "Read",
                fontColor: .titleGold
            ) {
                print("Read Lesson")
                isReadLessonPresented = true
            }
            
            Spacer(minLength: 30)

            
            // Next Question Button
            KHActionButton(
                state: $viewModel.nextQuestionButtonState,
                iconName: "arrow.right.circle.fill",
                iconSize: 60,
                title: viewModel.isLastQuestion ? "Finish" : "Next",
                fontColor: .titleGold
            ) {
                if !viewModel.isLastQuestion {
                    viewModel.goToNextQuestion()
                } else {
                    isPresented = false
                }
            }
        }
    }
    
    private var progressSection: some View {
        HStack {
            Text("\(viewModel.numberOfAnsweredQuestions) / \(viewModel.questionCount)")
                .font(.system(size: 14, weight: .heavy))
                .foregroundColor(.titleGold)
            
            ProgressIndicatorView(
                isVisible: $viewModel.isProgressIndicatorVisible,
                type: .bar(progress: $viewModel.progress, backgroundColor: .textColor)
            )
            .frame(maxWidth: .infinity, maxHeight: 3)
            .foregroundColor(.titleGold)
            .animation(.easeIn(duration: 0.3), value: viewModel.progress)
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Preview

#Preview {
    let quizViewModel = QuizViewModel(quiz: Testing.testQuiz)
    let colorManager = ColorManager(colorTheme: .midnightBlue)
    
    ZStack {
        colorManager.theme.backgroundColor
            .edgesIgnoringSafeArea(.all)
        
        QuizView(viewModel: quizViewModel, isPresented: .constant(true))
            .environmentObject(colorManager)
    }
}


