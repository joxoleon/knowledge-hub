//
//  ProgressTrackingRepository.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation


public protocol ProgressTrackingRepository {
    func fetchTracking(for questionId: String) -> QuestionTrackingData
    func updateTracking(for questionId: String, with data: QuestionTrackingData)
}

public struct QuestionTrackingData {
    var answerState: AnswerState
    static let `default` = QuestionTrackingData(answerState: .none)
}

public class InMemoryProgressTrackingRepository: ProgressTrackingRepository {
    private var questionTrackingData: [String: QuestionTrackingData] = [:]
    
    public func fetchTracking(for id: String) -> QuestionTrackingData {
        return questionTrackingData[id] ?? .default
    }
    
    public func updateTracking(for questionId: String, with data: QuestionTrackingData) {
        questionTrackingData[questionId] = data
    }
}

class UserDefaultsProgressTrackingRepository: ProgressTrackingRepository {
    private let userDefaults: UserDefaults
    private let storageKey = "ProgressTrackingData"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func fetchTracking(for questionId: String) -> QuestionTrackingData {
        guard let savedState = userDefaults.dictionary(forKey: storageKey)?[questionId] as? String,
              let answerState = AnswerState(rawValue: savedState) else {
            return .default
        }
        return QuestionTrackingData(answerState: answerState)
    }
    
    public func updateTracking(for questionId: String, with data: QuestionTrackingData) {
        var currentData = userDefaults.dictionary(forKey: storageKey) ?? [:]
        currentData[questionId] = data.answerState.rawValue
        userDefaults.set(currentData, forKey: storageKey)
    }
}

// MARK: - Placeholder
public extension InMemoryProgressTrackingRepository {
    static let placeholder = InMemoryProgressTrackingRepository()
}
