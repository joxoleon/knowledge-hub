//
//  AnswerButton.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI

enum ButtonState {
    case active, disabled, correct, wrong
}

struct AnswerButton: View {
    let answerText: String
    let state: ButtonState
    let onSelected: (String) -> Void
    
    var body: some View {
        Button(action: {
            onSelected(answerText)
        }) {
            Text(answerText)
                .font(font)
                .foregroundColor(color)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .background(
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        color.opacity(0.4),
                                        color.opacity(0.05)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .opacity(0.3)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color.opacity(0.3), lineWidth: 4)
                    }
                )
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 5)
        }
        .disabled(state != .active)
    }
    
    var font: Font {
        switch state {
        case .correct: return .system(size: 17, weight: .bold)
        case .wrong: return .system(size: 16, weight: .regular)
        case .active, .disabled: return .system(size: 16, weight: .semibold)
        }
    }
    
    var color: Color {
        switch state {
        case .active: return .white
        case .disabled: return Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        case .correct: return .green
        case .wrong: return .red
        }
    }
}

struct AnswerButton_Previews: PreviewProvider {
    @State static var selectedAnswer: Int? = nil
    static let colorManager = ColorManager(colorTheme: .midnightBlue)
    
    static var previews: some View {
        ZStack {
            colorManager.theme.backgroundColor
                .edgesIgnoringSafeArea(.all) // Ensure the background color covers the entire preview area
            VStack(spacing: 12) {
                AnswerButton(
                    answerText: "The capital of France is Paris.",
                    state: .active,
                    onSelected: { _ in selectedAnswer = 0 } // Update the @State variable
                )
                AnswerButton(
                    answerText: "The capital of Germany is Istanbul. But let's make this text a bit longer and see how it actually scales",
                    state: .disabled,
                    onSelected: { _ in selectedAnswer = 1 } // Update the @State variable
                )
                AnswerButton(
                    answerText: "The capital of Italy is Prague.",
                    state: .correct,
                    onSelected: { _ in selectedAnswer = 2 } // Update the @State variable
                )
                AnswerButton(
                    answerText: "The capital of Spain is MOJA KITA.",
                    state: .wrong,
                    onSelected: { _ in selectedAnswer = 3 } // Update the @State variable
                )
            }
            .padding()
        }
    }
}
