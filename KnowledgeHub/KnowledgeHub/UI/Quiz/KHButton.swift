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

struct KHButton: View {
    @EnvironmentObject var colorManager: ColorManager
    @Binding var state: ButtonState
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
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [buttonBackgroundColor.opacity(0.4), buttonBackgroundColor.opacity(0.05)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )))
                .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor, lineWidth: 3))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 5)
        }
        .disabled(state != .active)
        .animation(.easeInOut(duration: 0.5), value: state)
    }
}

fileprivate extension KHButton {
    
    var font: Font {
        return state == .correct ? .system(size: 18, weight: .bold) : .system(size: 16, weight: .semibold)
    }

    var buttonBackgroundColor: Color {
        switch state {
        case .active:
            return .white
        case .disabled:
            return Color(UIColor.systemGray)
        case .correct:
            return .green
        case .wrong:
            return .red
        }
    }

    var borderColor: Color {
        return state == .active ? colorManager.theme.buttonBorderColor : buttonBackgroundColor
    }

    var textColor: Color {
        return state == .active ? colorManager.theme.buttonTextColor : buttonBackgroundColor
    }
}

struct AnswerButton_Previews: PreviewProvider {
    @State static var buttonState: ButtonState = .active
    static var colorManager = ColorManager(colorTheme: .midnightBlue)
    
    static var previews: some View {
        ZStack {
            colorManager.theme.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                ForEach(0..<4) { index in
                    KHButton(
                        state: $buttonState,
                        answerText: "Answer \(index + 1)",
                        onSelected: { _ in buttonState = .correct }
                    )
                    .environmentObject(colorManager)
                }
            }
            .padding()
        }
    }
}
