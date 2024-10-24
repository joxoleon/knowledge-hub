//
//  MultipleChoiceQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

struct MultipleChoiceQuestion: Question {
    let id: QuestionId
    let profficiency: QuestionProfficiency
    let question: QuestionId
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
            id: "placeholderQuestionId",
            profficiency: .basic,
            question: "Placeholder question",
            answers: [
                "Placeholder answer 1",
                "Placeholder answer 2",
                "Placeholder answer 3",
                "Placeholder answer 4",
            ],
            correctAnswerIndex: 0,
            explanation: "Placeholder explanation",
            progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
        )
    }
}
