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
    var tags: [String] { get }
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

    // Summaries
    var summaries: [String] { get }

    // Search
    func relevanceScore(for query: String) -> Double

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

// MARK: - Search

fileprivate enum RelevanceConstants {
        static let titleWeight = 0.5
        static let tagWeight = 0.3
        static let descriptionWeight = 0.2
}

public extension LearningContent {

    func relevanceScore(for query: String) -> Double {
        let normalizedQuery = query.lowercased()
        let queryTokens = normalizedQuery.split(separator: " ").map { String($0) }

        // Normalize and tokenize content properties
        let titleTokens = title.lowercased().split(separator: " ").map { String($0) }
        let descriptionTokens = description.lowercased().split(separator: " ").map { String($0) }
        let tagTokens = tags.map { $0.lowercased() }

        // Calculate individual scores
        let titleScore = calculateTokenMatchScore(queryTokens, in: titleTokens) * RelevanceConstants.titleWeight
        let tagScore = calculateTokenMatchScore(queryTokens, in: tagTokens) * RelevanceConstants.tagWeight
        let descriptionScore = calculateTokenMatchScore(queryTokens, in: descriptionTokens) * RelevanceConstants.descriptionWeight

        // Final relevance score (0 to 1)
        return titleScore + tagScore + descriptionScore
    }

    private func calculateTokenMatchScore(_ queryTokens: [String], in contentTokens: [String]) -> Double {
        guard !contentTokens.isEmpty else { return 0.0 }
        
        let matchingTokens = queryTokens.filter { contentTokens.contains($0) }
        return Double(matchingTokens.count) / Double(queryTokens.count)
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
