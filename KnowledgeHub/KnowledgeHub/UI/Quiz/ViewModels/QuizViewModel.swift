//
//  QuizViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 25.10.24..
//

import SwiftUI

class QuizViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var quiz: Quiz
    @Published var isProgressIndicatorVisible = true
    @Published private(set) var currentQuestionIndex: Int {
        didSet {
            calculateProgress()
        }
    }
    @Published var selectedAnswer: String? {
        didSet {
            isNextButtonEnabled = selectedAnswer != nil
        }
    }
    
    // Automatically updated bindings
    @Published var isNextButtonEnabled = false
    @Published var progress: CGFloat = 0

    
    var currentQuestion: Question {
        quiz.questions[currentQuestionIndex]
    }
    
    var questionCount: Int {
        quiz.questions.count
    }

    // MARK: - Initializer
    
    init(quiz: Quiz) {
        self.quiz = quiz
        currentQuestionIndex = 0
    }
    
    // MARK: - Methods
    
    func submitAnswer(for question: Question, givenAnswer: String) {
        question.submitAnswer(givenAnswer)
        isNextButtonEnabled = true
    }

    func goToNextQuestion() {
        if currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
            isNextButtonEnabled = false
            selectedAnswer = nil
        }
    }
    
    // MARK: - Private methods
    
    private func calculateProgress() {
        progress = CGFloat(currentQuestionIndex) / CGFloat(quiz.questions.count)
    }
}
