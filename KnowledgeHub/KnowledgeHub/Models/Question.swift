//
//  QuizQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

enum AnsweredState {
    case none, correct, wrong
}

enum QuestionProfficiency {
    case basic, intermediate, advanced
}

protocol Question {
    var id: LearningContentId { get }
    var profficiency: QuestionProfficiency { get }
    var progressTrackingRepository: ProgressTrackingRepository { get set }
    func validateAnswer(_ givenAnswer: String) -> Bool
    func fetchExplanation() -> String
    func submitAnswer(_ givenAnswer: String)
}

extension Question {
    var answeredState: AnsweredState {
        progressTrackingRepository.fetchTracking(for: id).answeredState
    }
    
    var isComplete: Bool {
        progressTrackingRepository.fetchTracking(for: id).answeredState != .none
    }
}
