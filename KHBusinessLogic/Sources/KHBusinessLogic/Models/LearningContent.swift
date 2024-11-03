//
//  LearningContent.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation

public enum CompletionStatus {
    case notStarted
    case inProgress
    case completed
}

public protocol LearningContent: AnyObject {
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var questions: [Question] { get }
    var quiz: any Quiz { get }
    var contentProvider: any KHDomainContentProviderProtocol { get }

    var completionStatus: CompletionStatus { get }
    var completionPercentage: Double { get }
    var isComplete: Bool { get }
    var score: Double? { get }
    var estimatedReadTimeSeconds: Double { get }
}

public extension LearningContent {
    var completionStatus: CompletionStatus {
        quiz.completionStatus
    }

    var completionPercentage: Double {
        quiz.completionPercentage
    }

    var isComplete: Bool {
        return completionStatus == .completed
    }

    var score: Double? {
        quiz.quizScore
    }
}
