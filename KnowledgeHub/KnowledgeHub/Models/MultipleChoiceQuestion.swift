//
//  MultipleChoiceQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

struct MultipleChoiceQuestion: Question {
    let id: LearningContentId
    let profficiency: QuestionProfficiency
    let question: LearningContentId
    let answers: [String]
    let correctAnswerIndex: Int
    let explanation: String
    var progressTrackingRepository: ProgressTrackingRepository

    func validateAnswer(_ givenAnswer: String) -> Bool {
        return answers[correctAnswerIndex] == givenAnswer
    }

    func fetchExplanation() -> String {
        return explanation
    }

    func submitAnswer(_ givenAnswer: String) {
        var questionTrackingDataContainer = progressTrackingRepository.fetchTracking(for: id)
        questionTrackingDataContainer.answeredState = validateAnswer(givenAnswer) ? .correct : .wrong
        progressTrackingRepository.updateTracking(for: id, newState: questionTrackingDataContainer)
    }
}


// MARK: - Placeholder implementation

extension MultipleChoiceQuestion {
    static var placeholder: MultipleChoiceQuestion {
        MultipleChoiceQuestion(
            id: "swiftuiQuestionId",
            profficiency: .intermediate,
            question: "Which of the following is used to manage state in a SwiftUI view?",
            answers: [
                "@State",
                "@Binding",
                "@EnvironmentObject",
                "All of the above"
            ],
            correctAnswerIndex: 3,
            explanation: "In SwiftUI, @State, @Binding, and @EnvironmentObject are all used to manage state in different ways. @State is used for local state, @Binding is used to pass state between views, and @EnvironmentObject is used for shared state across the app.",
            progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
        )
    }
}
