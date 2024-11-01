//
//  MultipleChoiceQuestion.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 24.10.24..
//

import Foundation

struct MultipleChoiceQuestion: Question {
    let id: String
    let proficiency: QuestionProficiency
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    let explanation: String
    var progressTrackingRepository: ProgressTrackingRepository?
    
    func validateAnswer(_ givenAnswer: String) -> Bool {
        return answers.indices.contains(correctAnswerIndex) && answers[correctAnswerIndex] == givenAnswer
    }
    
    func fetchExplanation() -> String {
        return explanation
    }
}
