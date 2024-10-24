//
//  AnswerButton.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI

struct AnswerButton: View {
    let answerText: String
    let isCorrect: Bool
    let isSelected: Bool
    let onSelected: () -> Void

    var body: some View {
        Button(action: {
            onSelected()
        }) {
            Text(answerText)
                .font(.system(size: 16, weight: .medium))
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? (isCorrect ? Color.green : Color.red) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .animation(.easeInOut, value: isSelected) // Smooth transition
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct AnswerButton_Previews: PreviewProvider {
    @State static var selectedAnswer: Int? = nil // Declaring @State properly

    static var previews: some View {
        VStack {
            AnswerButton(
                answerText: "The capital of France is Paris.",
                isCorrect: true,
                isSelected: selectedAnswer == 0,
                onSelected: { selectedAnswer = 0 } // Update the @State variable
            )
            AnswerButton(
                answerText: "The capital of Germany is Istanbul. But let's make this text a bit longer and see how it actually scales",
                isCorrect: false,
                isSelected: selectedAnswer == 1,
                onSelected: { selectedAnswer = 1 } // Update the @State variable
            )
            AnswerButton(
                answerText: "The capital of Italy is Prague.",
                isCorrect: false,
                isSelected: selectedAnswer == 2,
                onSelected: { selectedAnswer = 2 } // Update the @State variable
            )
            AnswerButton(
                answerText: "The capital of Spain is Madrid.",
                isCorrect: false,
                isSelected: selectedAnswer == 3,
                onSelected: { selectedAnswer = 3 } // Update the @State variable
            )
        }
        .padding()
    }
}
