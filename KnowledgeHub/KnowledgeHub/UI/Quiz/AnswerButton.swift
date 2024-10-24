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
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    ZStack {
                        // Rectangle overlay for glassy appearance
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.6),
                                        Color.white.opacity(0.05)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .opacity(0.3)
                        
                        // RoundedRectangle outline for glassy border
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    }
                )
                .cornerRadius(12) // Ensures the RoundedRectangle has rounded corners
                .shadow(color: Color.black.opacity(0.6), radius: 3, x: 3, y: 5) // Add shadow for depth
        }
        .animation(.easeInOut, value: isSelected)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
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
}
