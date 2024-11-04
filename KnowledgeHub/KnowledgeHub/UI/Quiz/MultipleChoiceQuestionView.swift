//
//  MultipleChoiceQuestionView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI
import KHBusinessLogic

struct MultipleChoiceQuestionView: View {
    
    // MARK: - Properties
    @EnvironmentObject var colorManager: ColorManager
    @State private var buttonStates: [ButtonState]
    @Binding var selectedAnswer: String?
    
    let question: MultipleChoiceQuestion
    
    // MARK: - Initialization
    
    init(question: MultipleChoiceQuestion, selectedAnswer: Binding<String?>) {
        self.question = question
        _selectedAnswer = selectedAnswer
        _buttonStates = State(initialValue: Array(repeating: .active, count: question.answers.count))
    }

    // MARK: - UI
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            questionText
            answerButtons
            explanationSection
                .opacity(selectedAnswer != nil ? 1 : 0)
                .animation(.easeInOut(duration: 0.5), value: selectedAnswer != nil)
                .frame(maxWidth: .infinity)
        }
        .padding(18)
        .onChange(of: selectedAnswer) {
            updateButtonStates()
        }
    }

    // MARK: - Subviews
    
    private var questionText: some View {
        Text(question.question)
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(colorManager.theme.heading1TextColor)
            .padding(.vertical, 20)
    }

    private var answerButtons: some View {
        ForEach(0..<question.answers.count, id: \.self) { index in
            KHButton(
                state: $buttonStates[index],
                answerText: question.answers[index],
                onSelected: { answerText in
                    selectedAnswer = answerText
                }
            )
            .padding(.bottom, 8)
        }
    }

    private var explanationSection: some View {
        VStack {
            Text("TAKEAWAY")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(colorManager.theme.buttonBorderColor)
                .padding(.bottom, 8)
            
            Text(question.fetchExplanation())
                .font(.system(size: 14, weight: .medium))
                .background(colorManager.theme.questionExplanationBackgroundColor)
                .foregroundColor(colorManager.theme.questionExplanationTextColor)
                .padding()
                .background(colorManager.theme.questionExplanationBackgroundColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(colorManager.theme.questionExplanationBorderColor, lineWidth: 2)
                        .frame(maxWidth: .infinity)
                )
        }
        .padding([.top, .bottom], 8)
    }

    // MARK: - Private Methods
    
    private func updateButtonStates() {
        guard let selectedAnswer = selectedAnswer else {
            buttonStates = Array(repeating: .active, count: question.answers.count)
            return
        }

        buttonStates = question.answers.indices.map { index in
            if question.answers[index] == selectedAnswer {
                return index == question.correctAnswerIndex ? .correct : .wrong
            } else if index == question.correctAnswerIndex {
                return .correct
            } else {
                return .disabled
            }
        }
    }
}

struct MultipleChoicePreviewView: View {
    @State private var question: MultipleChoiceQuestion = Testing.testQuiz.questions.first as! MultipleChoiceQuestion
    @State private var resetTrigger: Bool = false
    @State private var selectedAnswer: String?

    var body: some View {
        VStack {
            Spacer()

            // Recreate the MultipleChoiceQuestionView when resetTrigger toggles
            MultipleChoiceQuestionView(question: question, selectedAnswer: $selectedAnswer)
                .id(resetTrigger) // Forces the view to reset when this id changes
            
            Spacer()
            
            Button("Reset") {
                // Toggling resetTrigger forces the view to reset
                resetTrigger.toggle()
            }
            .padding()
        }
    }
}

struct MultipleChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ColorManager(colorTheme: .midnightBlue).theme.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            MultipleChoicePreviewView()
                .environmentObject(ColorManager(colorTheme: .midnightBlue))

        }
    }
}
