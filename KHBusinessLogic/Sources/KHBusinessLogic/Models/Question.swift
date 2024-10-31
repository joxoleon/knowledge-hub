//
//  QuizQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

enum AnswerState: String {
    case none, correct, incorrect
}

enum QuestionProficiency {
    case basic, intermediate, advanced
}

protocol Question {
    var id: String { get }
    var proficiency: QuestionProficiency { get }
    var progressTrackingRepository: ProgressTrackingRepository? { get set }
    
    func validateAnswer(_ givenAnswer: String) -> Bool
    func fetchExplanation() -> String
    func submitAnswer(_ givenAnswer: String) -> Bool // Returns if the answer was correct
}

extension Question {
    var answerState: AnswerState {
        progressTrackingRepository?.fetchTracking(for: id).answerState ?? .none
    }
    
    var isComplete: Bool {
        answerState != .none
    }
    
    func submitAnswer(_ givenAnswer: String) -> Bool {
        let isCorrect = validateAnswer(givenAnswer)
        progressTrackingRepository?.updateTracking(for: id, with: QuestionTrackingData(answerState: isCorrect ? .correct : .incorrect))
        return isCorrect
    }
}
