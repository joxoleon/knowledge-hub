//
//  ProgressTrackingRepository.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

protocol ProgressTrackingRepository {
    func fetchTracking(for questionId: String) -> QuestionTrackingDataContainer
    func updateTracking(for questionId: String, newState: QuestionTrackingDataContainer)
}

struct QuestionTrackingDataContainer {
    var answeredState: AnsweredState
}

class InMemoryProgressTrackingRepository: ProgressTrackingRepository {
    private var questionTrackingData: [String: QuestionTrackingDataContainer] = [:]

    func fetchTracking(for id: String) -> QuestionTrackingDataContainer {
        return questionTrackingData[id] ?? QuestionTrackingDataContainer(answeredState: .none)
    }

    func updateTracking(for questionId: String, newState: QuestionTrackingDataContainer) {
        questionTrackingData[questionId] = newState
    }
}

// Need to implement additional tracking Repositories (UserDefaults, CoreData, etc.)

// MARK: - Placeholder implementation

extension InMemoryProgressTrackingRepository {
    static let placeholderTrackingRepository = InMemoryProgressTrackingRepository()
}
