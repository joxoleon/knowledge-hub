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
            nextQuestionButtonState = selectedAnswer != nil ? .active : .disabled
        }
    }
    
    // Automatically updated bindings
    @Published var readLessonButonState: ButtonState = .active
    @Published var nextQuestionButtonState: ButtonState = .disabled
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
        print("Submitting answer: \(givenAnswer)")
        question.submitAnswer(givenAnswer)
        nextQuestionButtonState = .disabled
    }

    func goToNextQuestion() {
        print("Going to next question")
        if currentQuestionIndex < quiz.questions.count - 1 {
            currentQuestionIndex += 1
            nextQuestionButtonState = .active
            print("Setting selected answer to nil")
            selectedAnswer = nil
        }
    }
    
    // MARK: - Private methods
    
    private func calculateProgress() {
        print("Calculating progress")
        progress = CGFloat(currentQuestionIndex) / CGFloat(quiz.questions.count)
    }
}
