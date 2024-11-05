//
//  QuizViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 25.10.24..
//

import SwiftUI
import KHBusinessLogic

class QuizViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var quiz: Quiz
    @Published var isProgressIndicatorVisible = true
    @Published private(set) var currentQuestionIndex: Int
    @Published var selectedAnswer: String? {
        didSet {
            nextQuestionButtonState = selectedAnswer != nil ? .active : .disabled
            calculateProgress()
        }
    }
    
    // Automatically updated bindings
    @Published var readLessonButonState: ButtonState = .active
    @Published var nextQuestionButtonState: ButtonState = .disabled
    @Published var progress: CGFloat = 0
    @Published var shouldShowLessionOverviewView: Bool = false

    
    var currentQuestion: Question {
        quiz.questions[currentQuestionIndex]
    }
    
    var questionCount: Int {
        quiz.questions.count
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex == questionCount - 1
    }
    
    var numberOfAnsweredQuestions: Int {
        currentQuestionIndex + (selectedAnswer != nil ? 1 : 0)
    }

    // MARK: - Initializer
    
    init(quiz: Quiz) {
        self.quiz = quiz
        currentQuestionIndex = 0
    }
    
    // MARK: - Methods
    
    func submitAnswer(for question: Question, givenAnswer: String) {
        print("Submitting answer: \(givenAnswer)")
        let _ = question.submitAnswer(givenAnswer)
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
    
    func readLesson() {
        shouldShowLessionOverviewView = true
    }
    
    // MARK: - Private methods
    
    private func calculateProgress() {
        print("Calculating progress")
        progress = CGFloat(numberOfAnsweredQuestions) / CGFloat(quiz.questions.count)
    }
}
