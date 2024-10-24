//
//  MultipleChoiceQuestionView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI

struct MultipleChoiceQuestionView: View {
    @EnvironmentObject var colorManager: ColorManager
    @State private var selectedAnswer: String?
    @State private var buttonStates: [ButtonState]
    
    let question: MultipleChoiceQuestion
    
    var hasSubmittedAnswer: Bool {
        selectedAnswer != nil
    }
    
    init(question: MultipleChoiceQuestion) {
        self.question = question
        _buttonStates = State(initialValue: Array(repeating: .active, count: question.answers.count))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 25)
                .padding(.bottom, 25)

            // Display answer buttons
            ForEach(0..<question.answers.count, id: \.self) { index in
                AnswerButton(
                    answerText: question.answers[index],
                    state: buttonStates[index],
                    onSelected: { answerText in
                        handleAnswerSelection(index: index, answerText: answerText)
                    }
                )
                .padding(.bottom, 8)
            }

            Text(question.fetchExplanation())
                .font(.subheadline)
                .padding()
                .background(colorManager.theme.backgroundLighterColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 2)
                )
                .padding(.top, 16)
//                .opacity(hasSubmittedAnswer ? 1 : 0)
                .animation(.easeInOut, value: hasSubmittedAnswer)
        }
        .padding()
    }

    // Handle the answer selection and update button states
    func handleAnswerSelection(index: Int, answerText: String) {
        // Prevent further selection if an answer has already been submitted
        if hasSubmittedAnswer { return }
        selectedAnswer = answerText

        // Update the button states
        for i in 0..<buttonStates.count {
            if i == index {
                buttonStates[i] = question.correctAnswerIndex == index ? .correct : .wrong
            } else if i == question.correctAnswerIndex {
                buttonStates[i] = .correct
            } else {
                buttonStates[i] = .disabled
            }
        }

        question.submitAnswer(answerText)
    }
    
    func reset() {
        selectedAnswer = nil
        buttonStates = Array(repeating: .active, count: question.answers.count)
    }
}

struct MultipleChoicePreviewView: View {
    @State private var question: MultipleChoiceQuestion = MultipleChoiceQuestion.placeholder
    @State private var resetTrigger: Bool = false

    var body: some View {
        VStack {
            Spacer()

            // Recreate the MultipleChoiceQuestionView when resetTrigger toggles
            MultipleChoiceQuestionView(question: question)
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
