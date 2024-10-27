//
//  QuizView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 25.10.24..
//

import SwiftUI
import ProgressIndicatorView

struct QuizView: View {
    @EnvironmentObject var colorManager: ColorManager
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                if let multipleChoiceQuestion = viewModel.currentQuestion as? MultipleChoiceQuestion {
                    MultipleChoiceQuestionView(
                        question: multipleChoiceQuestion,
                        selectedAnswer: $viewModel.selectedAnswer
                    )
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollIndicators(.visible)
            
            progressSection
            navigationButtonSection
                .padding(.bottom, 20)
                .padding(.top, 4)
        }
    }
    
    // MARK: - Subviews
    
    private var navigationButtonSection: some View {
        HStack {
            NavigationLink(
                // TODO: Change lesson placeholder to something sensible
                destination: ReadLessonView(viewModel: LessonViewModel(lesson: Lesson.placeholder, colorManager: colorManager)),
                isActive: $viewModel.shouldShowLessionOverviewView // A @Published var in QuizViewModel
            ) {
                KHButton(
                    state: $viewModel.readLessonButonState,
                    answerText: "Read Lesson",
                    onSelected: { _ in
                        print("Read Lesson Button Pressed")
                        viewModel.readLesson()
                    }
                )
                .animation(.easeIn(duration: 0.5), value: viewModel.readLessonButonState)
            }
            
            Spacer(minLength: 30)
            
            KHButton(
                state: $viewModel.nextQuestionButtonState,
                answerText: viewModel.isLastQuestion ? "Done" : "Next",
                onSelected: { _ in
                    print("Next Question Button Pressed")
                    viewModel.goToNextQuestion()
                }
            )
            .animation(.easeIn(duration: 0.5), value: viewModel.nextQuestionButtonState)
        }
        .padding(.horizontal, 35)
    }
    
    private var progressSection: some View {
        HStack {
            Text("\(viewModel.numberOfAnsweredQuestions) / \(viewModel.questionCount)")
                .font(.system(size: 14, weight: .heavy))
                .foregroundColor(colorManager.theme.buttonBorderColor)
            
            ProgressIndicatorView(
                isVisible: $viewModel.isProgressIndicatorVisible,
                type: .dashBar(
                    progress: $viewModel.progress,
                    numberOfItems: viewModel.questionCount,
                    backgroundColor: colorManager.theme.textColor
                )
            )
            .frame(maxWidth: .infinity, maxHeight: 4)
            .foregroundColor(colorManager.theme.buttonBorderColor)
            .animation(.easeIn(duration: 0.5), value: viewModel.progress)
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - Preview

#Preview {
    let sampleQuiz = QuizImpl.placeholderQuiz
    let quizViewModel = QuizViewModel(quiz: sampleQuiz)
    let colorManager = ColorManager(colorTheme: .midnightBlue)
    
    return ZStack {
        colorManager.theme.backgroundColor
            .edgesIgnoringSafeArea(.all)
        
        QuizView(viewModel: quizViewModel)
            .environmentObject(colorManager)
    }
}


