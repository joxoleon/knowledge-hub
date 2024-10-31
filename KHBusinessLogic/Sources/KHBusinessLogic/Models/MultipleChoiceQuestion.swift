//
//  MultipleChoiceQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

struct MultipleChoiceQuestion: Question {
    let id: String
    let profficiency: QuestionProfficiency
    let question: String
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
