//
//  QuizQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

public typealias QuestionId = String

enum AnsweredState {
    case none, correct, wrong
}

enum QuestionProfficiency {
    case basic, intermediate, advanced
}

protocol Question {
    var id: QuestionId { get } // Unique identifier for the question (module, lesson, etc.)
    var profficiency: QuestionProfficiency { get } // For determinng the question difficulty
    var progressTrackingRepository: ProgressTrackingRepository { get set } // Keeps track of answer state
    func validateAnswer(_ givenAnswer: String) -> Bool // Validates if the answer is correct
    func fetchExplanation() -> String // Returns the explanation for the correct answer
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
