//
//  Quiz.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

protocol Quiz {
    var id: String { get }
    var questions: [Question] { get }
    var progressTrackingRepository: ProgressTrackingRepository { get }

    func calculateQuizScore() -> Double // Calculate the score as percentage of correct answers
    func isComplete() -> Bool // Check if all questions are answered
    func completenessPercentage() -> Double
}

// MARK: - Concrete Implementation of Quiz

struct QuizImpl: Quiz {
    let id: String
    var questions: [Question]
    var progressTrackingRepository: ProgressTrackingRepository

    // Calculate score by checking how many questions have been answered correctly
    func calculateQuizScore() -> Double {
        let correctAnswers = questions.filter { $0.answeredState == .correct }.count
        return (Double(correctAnswers) / Double(questions.count)) * 100
    }

    // Check if all questions in the quiz are answered
    func isComplete() -> Bool {
        return questions.allSatisfy { $0.answeredState != .none }
    }

    // Calculate the number of answered questions and return it as a completeness percentage
    func completenessPercentage() -> Double {
        return Double(questions.filter(\.self.isComplete).count) / Double(questions.count) * 100
    }
}

// MARK: - Example Usage of GeneralQuiz

extension QuizImpl {
    static var placeholderQuiz: QuizImpl {
        QuizImpl(
            id: "generalQuizExample",
            questions: [
                MultipleChoiceQuestion(
                    id: "q1",
                    profficiency: .basic,
                    question: "What is the capital of France?",
                    answers: ["Berlin", "Madrid", "Paris", "Rome"],
                    correctAnswerIndex: 2,
                    explanation: "Paris is the capital of France.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q2",
                    profficiency: .intermediate,
                    question: "Which programming language is used for iOS development?",
                    answers: ["Python", "Swift", "Java", "Kotlin"],
                    correctAnswerIndex: 1,
                    explanation: "Swift is the main programming language for iOS development.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                )
            ],
            progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
        )
    }
}

