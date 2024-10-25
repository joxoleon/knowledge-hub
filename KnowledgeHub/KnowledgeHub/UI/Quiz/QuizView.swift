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
            // Current Question
            if let multipleChoiceQuestion = viewModel.currentQuestion as? MultipleChoiceQuestion {
                MultipleChoiceQuestionView(question: multipleChoiceQuestion, selectedAnswer: $viewModel.selectedAnswer)
                    .padding()
            }

            // Next Button
            Button(action: {
                print("Next Button Pressed")
                viewModel.goToNextQuestion()
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isNextButtonEnabled ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(!viewModel.isNextButtonEnabled)
            
            // Progress
            HStack {
                Text("\(viewModel.currentQuestionIndex) / \(viewModel.questionCount)")
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
            }
            .padding(.horizontal, 40)
        }
    }
}

// QuizView Preview Implementation
#Preview {
    let sampleQuiz = QuizImpl.placeholderQuiz
    let quizViewModel = QuizViewModel(quiz: sampleQuiz)
    let colorManager = ColorManager(colorTheme: .midnightBlue)
    return ZStack {
        colorManager.theme.backgroundColor
            .edgesIgnoringSafeArea(.all)
        
        QuizView(viewModel: quizViewModel)
            .environmentObject(ColorManager(colorTheme: .midnightBlue))
    }

}

