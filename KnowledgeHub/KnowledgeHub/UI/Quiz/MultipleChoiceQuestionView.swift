//
//  MultipleChoiceQuestionView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI

struct MultipleChoiceQuestionView: View {
    @State private var selectedAnswer: String? = nil
    @State private var buttonStates: [ButtonState] = []
    
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
                .font(.headline)
                .padding(.bottom, 16)

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

            // Explanation section (after submission)
            if hasSubmittedAnswer {
                Text(question.fetchExplanation())
                    .font(.subheadline)
                    .padding(.top, 16)
                    .transition(.opacity)
            }
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
                if question.correctAnswerIndex == index {
                    buttonStates[i] = .correct
                } else {
                    buttonStates[i] = .wrong
                }
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
    @State private var multipleChoiceQuestionView: MultipleChoiceQuestionView?

    var body: some View {
        VStack {
            Spacer()
            
            if let multipleChoiceQuestionView = multipleChoiceQuestionView {
                multipleChoiceQuestionView
            } else {
                MultipleChoiceQuestionView(question: question)
                    .onAppear {
                        self.multipleChoiceQuestionView = MultipleChoiceQuestionView(question: question)
                    }
            }
            
            Spacer()
            
            Button("Reset") {
                multipleChoiceQuestionView?.reset()
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
        }
    }
}
