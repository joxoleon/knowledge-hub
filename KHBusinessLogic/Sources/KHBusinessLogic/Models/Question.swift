//
//  QuizQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

public enum AnswerState: String {
    case none, correct, incorrect
}

public enum QuestionProficiency: String {
    case basic, intermediate, advanced
}

public protocol Question {
    var id: String { get }
    var proficiency: QuestionProficiency { get }
    var progressTrackingRepository: any ProgressTrackingRepository { get }
    var contentProvider: any KHDomainContentProviderProtocol { get }
    var lessonId: String { get }
    
    func validateAnswer(_ givenAnswer: String) -> Bool
    func fetchExplanation() -> String
    func submitAnswer(_ givenAnswer: String) -> Bool
}

public extension Question {

    var progressTrackingRepository: ProgressTrackingRepository {
        contentProvider.progressTrackingRepository
    }

    var answerState: AnswerState {
        progressTrackingRepository.fetchTracking(for: id).answerState
    }
    
    var isComplete: Bool {
        answerState != .none
    }

    var lesson: Lesson? {
        contentProvider.getLesson(by: lessonId)
    }
    
    func submitAnswer(_ givenAnswer: String) -> Bool {
        let isCorrect = validateAnswer(givenAnswer)
        progressTrackingRepository.updateTracking(for: id, with: QuestionTrackingData(answerState: isCorrect ? .correct : .incorrect))
        return isCorrect
    }
}

// MARK: - Multiple Choice Question

public struct MultipleChoiceQuestion: Question {
    
    // MARK: - Properties

    public let id: String
    public let proficiency: QuestionProficiency
    public let question: String
    public let answers: [String]
    public let correctAnswerIndex: Int
    public let explanation: String
    public let lessonId: String
    public let contentProvider: any KHDomainContentProviderProtocol

    // MARK: - Iinitialization

    public init(
        id: String,
        proficiency: QuestionProficiency,
        question: String,
        answers: [String],
        correctAnswerIndex: Int,
        explanation: String,
        lessonId: String,
        contentProvider: any KHDomainContentProviderProtocol
    ) {
        self.id = id
        self.proficiency = proficiency
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        self.explanation = explanation
        self.lessonId = lessonId
        self.contentProvider = contentProvider
    }

    public init(from dtoQuestion: KHContentSource.Question, contentProvider: any KHDomainContentProviderProtocol) {
        self.id = dtoQuestion.id
        self.proficiency = QuestionProficiency(rawValue: dtoQuestion.proficiency) ?? .basic
        self.question = dtoQuestion.question
        self.answers = dtoQuestion.answers
        self.correctAnswerIndex = dtoQuestion.correctAnswerIndex
        self.explanation = dtoQuestion.explanation
        self.lessonId = dtoQuestion.id
        self.contentProvider = contentProvider
    }
    
    public func validateAnswer(_ givenAnswer: String) -> Bool {
        return answers.indices.contains(correctAnswerIndex) && answers[correctAnswerIndex] == givenAnswer
    }
    
    public func fetchExplanation() -> String {
        return explanation
    }
}
