//
//  MultipleChoiceQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation
import KHContentSource

public struct MultipleChoiceQuestion: Question {
    
    // MARK: - Properties

    public let id: String
    public let proficiency: QuestionProficiency
    public let question: String
    public let answers: [String]
    public let correctAnswerIndex: Int
    public let explanation: String
    public var progressTrackingRepository: any ProgressTrackingRepository

    // MARK: - Iinitialization

    public init(
        id: String,
        proficiency: QuestionProficiency,
        question: String,
        answers: [String],
        correctAnswerIndex: Int,
        explanation: String,
        progressTrackingRepository: any ProgressTrackingRepository
    ) {
        self.id = id
        self.proficiency = proficiency
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        self.explanation = explanation
        self.progressTrackingRepository = progressTrackingRepository
    }

    public init(from dtoQuestion: KHContentSource.Question, progressTrackingRepository: any ProgressTrackingRepository) {
        self.id = dtoQuestion.id
        self.proficiency = QuestionProficiency(rawValue: dtoQuestion.proficiency) ?? .basic
        self.question = dtoQuestion.question
        self.answers = dtoQuestion.answers
        self.correctAnswerIndex = dtoQuestion.correctAnswerIndex
        self.explanation = dtoQuestion.explanation
        self.progressTrackingRepository = progressTrackingRepository
    }
    
    public func validateAnswer(_ givenAnswer: String) -> Bool {
        return answers.indices.contains(correctAnswerIndex) && answers[correctAnswerIndex] == givenAnswer
    }
    
    public func fetchExplanation() -> String {
        return explanation
    }
}
