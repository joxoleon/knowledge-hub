//
//  Quiz.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

protocol Quiz {
    var id: String { get }
    var questions: [Question] { get }
    var progressTrackingRepository: ProgressTrackingRepository { get }
    var completionStatus: CompletionStatus { get }
    var completionPercentage: Double { get }
    var quizScore: Double? { get }
}

// MARK: - Concrete Implementation of Quiz

struct QuizImpl: Quiz {
    let id: String
    let questions: [Question]
    let progressTrackingRepository: ProgressTrackingRepository
    
    var completionStatus: CompletionStatus {
        let completedQuestionCount = questions.filter(\.self.isComplete).count
        if completedQuestionCount == questions.count {
            return .completed
        } else if completedQuestionCount == 0 {
            return .notStarted
        } else {
            return .inProgress
        }
    }
    
    var completionPercentage: Double {
        return Double(questions.filter(\.self.isComplete).count) / Double(questions.count) * 100
    }
    
    var quizScore: Double? {
        guard completionStatus != .notStarted else { return nil }
        let correctAnswers = questions.filter { $0.answerState == .correct }.count
        return (Double(correctAnswers) / Double(questions.count)) * 100
    }
}

