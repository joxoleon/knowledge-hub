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
    var learningContents: [any LearningContent] { get }
    var debugDescription: String { get }
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

    var debugDescription: String {
        let type = type(of: self)
        let contentString = learningContents.isEmpty 
        ?  "" 
        : """
        contents: {
        \(learningContents.map { $0.debugDescription.indented(by: 4) }.joined(separator: "\n"))
        }
        """
        return """
        \(type)
        title: \(title)
        completionStatus: \(completionStatus)
        completionPercentage: \(completionPercentage)
        isComplete: \(isComplete)
        score: \(score.map { "\($0)" } ?? "nil")
        estimatedReadTimeSeconds: \(estimatedReadTimeSeconds)
        \(contentString)
        """
    }
}

private extension String {
    func indented(by spaces: Int) -> String {
        let indent = String(repeating: " ", count: spaces)
        return self.split(separator: "\n").map { indent + $0 }.joined(separator: "\n")
    }
}
