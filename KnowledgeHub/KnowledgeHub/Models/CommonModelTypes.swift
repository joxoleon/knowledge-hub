//
//  CommonModelTypes.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 27.10.24..
//

import Foundation

public enum CompletionStatus {
    case notStarted
    case inProgress
    case completed
}

protocol LearningContent {
    var id: LearningContentId { get }
    var title: String { get }
    var description: String? { get }
    var allQuestions: [Question] { get }
    var quiz: Quiz { get }
    
    var completionStatus: CompletionStatus { get }
    var completionPercentage: Double { get }
    var score: Double? { get }
}

extension LearningContent {
    var completionStatus: CompletionStatus {
        quiz.completionStatus
    }
    
    var completionPercentage: Double {
        quiz.completionPercentage
    }
    
    var score: Double? {
        quiz.quizScore
    }
}

public struct LearningContentId: Hashable {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    func toQuizId() -> QuizId {
        QuizId(value + "Quiz")
    }
}

public struct QuizId: Hashable {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    func toLearningContentId() -> LearningContentId {
        LearningContentId(value.replacingOccurrences(of: "Quiz", with: ""))
    }
}

public struct QuestionId: Hashable {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
}
