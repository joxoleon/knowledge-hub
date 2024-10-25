//
//  MultipleChoiceQuestionView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI

struct MultipleChoiceQuestionView: View {
    
    // MARK: - Properties
    @EnvironmentObject var colorManager: ColorManager
    @State private var buttonStates: [ButtonState]
    @Binding var selectedAnswer: String? {
        didSet {
            updateButtonStates()
        }
    }
    
    let question: MultipleChoiceQuestion
    
    // MARK: - Initialization
    
    init(question: MultipleChoiceQuestion, selectedAnswer: Binding<String?>) {
        self.question = question
        _buttonStates = State(initialValue: Array(repeating: .active, count: question.answers.count))
        _selectedAnswer = selectedAnswer
    }

    // MARK: - UI
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(colorManager.theme.heading1TextColor)
                .padding([.top, .bottom], 20)

            ForEach(0..<question.answers.count, id: \.self) { index in
                KHButton(
                    answerText: question.answers[index],
                    state: buttonStates[index],
                    onSelected: { answerText in
                        selectedAnswer = answerText
                    }
                )
                .padding(.bottom, 8)
            }

            VStack {
                Text("TAKEAWAY")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(colorManager.theme.buttonBorderColor)
                    .padding(.bottom, 8)
                
                Text(question.fetchExplanation())
                    .font(.system(size: 14, weight: .medium))
                    .background(colorManager.theme.questionExplanationBackgroundColor)
                    .foregroundColor(colorManager.theme.questionExplanationTextColor)
            }
            .padding([.top, .bottom], 8)
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorManager.theme.questionExplanationBackgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(colorManager.theme.questionExplanationBorderColor, lineWidth: 2)
            )
            .opacity(selectedAnswer != nil ? 1 : 0)
            .animation(.easeInOut(duration: 0.5), value: selectedAnswer != nil)

        }
        .padding(18)
    }


    
    // MARK: - Private methods
    
    private func updateButtonStates() {
        guard let selectedAnswer = selectedAnswer,
              let selectedIndex = question.answers.firstIndex(of: selectedAnswer) else {
            return
        }
    
        buttonStates = buttonStates.enumerated().map { index, state in
            if index == selectedIndex {
                return question.correctAnswerIndex == index ? .correct : .wrong
            } else if index == question.correctAnswerIndex {
                return .correct
            } else {
                return .disabled
            }
        }
    }
    
    // MARK: - Preview
    
    private func reset() {
        selectedAnswer = nil
        buttonStates = Array(repeating: .active, count: question.answers.count)
    }
}

struct MultipleChoicePreviewView: View {
    @State private var question: MultipleChoiceQuestion = MultipleChoiceQuestion.placeholder
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
