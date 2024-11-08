//
//  KHQuizAnswerButton.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import SwiftUI

enum KHQuizAnswerButtonState {
    case active, disabled, correct, wrong
}

struct KHQuizAnswerButton: View {
    @Binding var state: KHQuizAnswerButtonState
    let answerText: String
    let onSelected: (String) -> Void
    
    var body: some View {
        Button(action: {
            onSelected(answerText)
        }) {
            Text(answerText)
                .font(font)
                .foregroundColor(textColor)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(ThemeConstants.cellGradient)
                )
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1))
        }
        .disabled(state != .active)
        .animation(.easeInOut(duration: 0.2), value: state)
    }
}

fileprivate extension KHQuizAnswerButton {
    
    var font: Font {
        return .system(size: 16, weight: .semibold)
    }
    
    var borderColor: Color {
        switch state {
        case .active: return .titleGold
        case .disabled: return .placeholderGray
        case .correct: return .green
        case .wrong: return .red
        }
    }
    
    var textColor: Color {
        switch state {
        case .active: return .textColor
        case .disabled: return .placeholderGray
        case .correct: return .green
        case .wrong: return .red
        }
    }
}

struct AnswerButton_Previews: PreviewProvider {
    @State static var buttonState: KHQuizAnswerButtonState = .active
    
    static var previews: some View {
        ZStack {
            
            ThemeConstants.verticalGradient.ignoresSafeArea()

            VStack(spacing: 12) {
                ForEach(0..<4) { index in
                    KHQuizAnswerButton(
                        state: $buttonState,
                        answerText: "Answer \(index + 1)",
                        onSelected: { _ in buttonState = .correct }
                    )
                }
            }
            .padding()
        }
    }
}
