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

    // Basic Properties
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var learningContents: [any LearningContent] { get }
    var questions: [Question] { get }
    var quiz: any Quiz { get }

    // Services
    var contentProvider: any KHDomainContentProviderProtocol { get }

    // Progress and Completion
    var completionStatus: CompletionStatus { get }
    var completionPercentage: Double { get }
    var isComplete: Bool { get }
    var score: Double? { get }
    var estimatedReadTimeSeconds: Double { get }

    // Starring
    var isStarred: Bool { get }
    func star()
    func unstar()
    func starContentsRecursively()
    func unstarContentsRecursively()

    // MARK: - Debugging
    var debugDescription: String { get }

}

// MARK: - Progress and Completion

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

// MARK: - Starring

public extension LearningContent {
    var isStarred: Bool {
        return contentProvider.starTrackingRepository.isStarred(id: id)
    }
    
    func toggleStar() {
        isStarred ? unstar() : star()
    }

    func star() {
        contentProvider.starTrackingRepository.star(id: id)
    }

    func unstar() {
        contentProvider.starTrackingRepository.unstar(id: id)
    }

    func starContentsRecursively() {
        star()
        learningContents.forEach { $0.starContentsRecursively() }
    }

    func unstarContentsRecursively() {
        unstar()
        learningContents.forEach { $0.unstarContentsRecursively() }
    }
}

// MARK: - Content Iteration

public extension LearningContent {
    var levelOrderModules: [LearningModule] {
        var modules: [LearningModule] = []
        var queue: [LearningContent] = [self]
        while !queue.isEmpty {
            let content = queue.removeFirst()
            if let module = content as? LearningModule {
                modules.append(module)
                queue.append(contentsOf: module.learningContents)
            }
        }
        return modules
    }

    var preOrderLessons: [Lesson] {
        var lessons: [Lesson] = []
        learningContents.forEach { content in
            if let lesson = content as? Lesson {
                lessons.append(lesson)
            } else if let module = content as? LearningModule {
                lessons.append(contentsOf: module.preOrderLessons)
            }
        }
        return lessons
    }
}

// MARK: - Debugging

public extension LearningContent {
    var debugDescription: String {
        let type = type(of: self)
        let contentString =
            learningContents.isEmpty
            ? ""
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

extension String {
    fileprivate func indented(by spaces: Int) -> String {
        let indent = String(repeating: " ", count: spaces)
        return self.split(separator: "\n").map { indent + $0 }.joined(separator: "\n")
    }
}
