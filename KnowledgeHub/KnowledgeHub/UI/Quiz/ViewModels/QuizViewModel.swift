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
    @Published var quiz: Quiz
    @Published var isProgressIndicatorVisible = true
    @Published private(set) var currentQuestionIndex: Int
    @Published var selectedAnswer: String? {
        didSet {
            nextQuestionButtonState = selectedAnswer != nil ? .active : .disabled
            calculateProgress()
            if let answer = selectedAnswer {
                submitAnswer(for: currentQuestion, givenAnswer: answer)
            }
        }
    }
    
    // Automatically updated bindings
    @Published var readLessonButonState: KHActionButtonState = .active
    @Published var nextQuestionButtonState: KHActionButtonState = .disabled
    @Published var progress: CGFloat = 0
    @Published var shouldShowLessionOverviewView: Bool = false

    private var privateId: UUID = UUID()
    
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
    
    var lessonForCurrentQuestion: Lesson? {
        let lesson = quiz.questions[currentQuestionIndex].lesson
        print("Lesson for current question: \(lesson?.title ?? "No lesson")")
        return lesson
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
        progress = CGFloat(numberOfAnsweredQuestions) / CGFloat(quiz.questions.count)
    }
}

extension QuizViewModel: Hashable, Equatable {
    static func == (lhs: QuizViewModel, rhs: QuizViewModel) -> Bool {
        lhs.quiz.id == rhs.quiz.id && lhs.privateId == rhs.privateId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quiz.id)
        hasher.combine(privateId)
    }
}
