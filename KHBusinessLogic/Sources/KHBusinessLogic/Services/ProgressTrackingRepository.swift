//
//  ProgressTrackingRepository.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation


protocol ProgressTrackingRepository {
    func fetchTracking(for questionId: String) -> QuestionTrackingData
    func updateTracking(for questionId: String, with data: QuestionTrackingData)
}

struct QuestionTrackingData {
    var answerState: AnswerState
    static let `default` = QuestionTrackingData(answerState: .none)
}

// MARK: - In-Memory Implementation
class InMemoryProgressTrackingRepository: ProgressTrackingRepository {
    private var questionTrackingData: [String: QuestionTrackingData] = [:]
    
    func fetchTracking(for id: String) -> QuestionTrackingData {
        return questionTrackingData[id] ?? .default
    }
    
    func updateTracking(for questionId: String, with data: QuestionTrackingData) {
        questionTrackingData[questionId] = data
    }
}

// MARK: - UserDefaults-Based Implementation
class UserDefaultsProgressTrackingRepository: ProgressTrackingRepository {
    private let userDefaults: UserDefaults
    private let storageKey = "ProgressTrackingData"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func fetchTracking(for questionId: String) -> QuestionTrackingData {
        guard let savedState = userDefaults.dictionary(forKey: storageKey)?[questionId] as? String,
              let answerState = AnswerState(rawValue: savedState) else {
            return .default
        }
        return QuestionTrackingData(answerState: answerState)
    }
    
    func updateTracking(for questionId: String, with data: QuestionTrackingData) {
        var currentData = userDefaults.dictionary(forKey: storageKey) ?? [:]
        currentData[questionId] = data.answerState.rawValue
        userDefaults.set(currentData, forKey: storageKey)
    }
}

// MARK: - Placeholder
extension InMemoryProgressTrackingRepository {
    static let placeholder = InMemoryProgressTrackingRepository()
}
