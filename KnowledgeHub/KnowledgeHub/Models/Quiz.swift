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
    var lesson: Lesson { get }

    func calculateQuizScore() -> Double // Calculate the score as percentage of correct answers
    func isComplete() -> Bool // Check if all questions are answered
    func completenessPercentage() -> Double
}

// MARK: - Concrete Implementation of Quiz

struct QuizImpl: Quiz {
    let id: String
    let questions: [Question]
    let progressTrackingRepository: ProgressTrackingRepository
    let lesson: Lesson

    // Calculate score by checking how many questions have been answered correctly
    func calculateQuizScore() -> Double {
        let correctAnswers = questions.filter { $0.answeredState == .correct }.count
        return (Double(correctAnswers) / Double(questions.count)) * 100
    }

    // Check if all questions in the quiz are answered
    func isComplete() -> Bool {
        return questions.allSatisfy { $0.answeredState != .none }
    }

    // Calculate the number of answered questions and return it as a completeness percentage
    func completenessPercentage() -> Double {
        return Double(questions.filter(\.self.isComplete).count) / Double(questions.count) * 100
    }
}

// MARK: - Example Usage of GeneralQuiz

extension QuizImpl {
    static var placeholderQuiz: QuizImpl {
        QuizImpl(
            id: "generalQuizExample",
            questions: [
                MultipleChoiceQuestion(
                    id: "q1",
                    profficiency: .basic,
                    question: "What is the main programming language used for iOS development?",
                    answers: ["Python", "Swift", "Java", "Kotlin"],
                    correctAnswerIndex: 1,
                    explanation: "Swift is the main programming language for iOS development.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q2",
                    profficiency: .intermediate,
                    question: "Which framework is used for building user interfaces in iOS?",
                    answers: ["UIKit", "React Native", "Flutter", "Xamarin"],
                    correctAnswerIndex: 0,
                    explanation: "UIKit is the primary framework used for building user interfaces in iOS.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q3",
                    profficiency: .advanced,
                    question: "What is the purpose of the @State property wrapper in SwiftUI?",
                    answers: ["To manage state in a view", "To create a new view", "To handle network requests", "To manage memory"],
                    correctAnswerIndex: 0,
                    explanation: "@State is used to manage state in a SwiftUI view.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q4",
                    profficiency: .basic,
                    question: "What is the file extension for Swift source files?",
                    answers: [".swift", ".java", ".py", ".js"],
                    correctAnswerIndex: 0,
                    explanation: "The file extension for Swift source files is .swift.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q5",
                    profficiency: .intermediate,
                    question: "Which tool is used to manage dependencies in Swift projects?",
                    answers: ["CocoaPods", "npm", "Maven", "Gradle"],
                    correctAnswerIndex: 0,
                    explanation: "CocoaPods is a dependency manager for Swift and Objective-C projects.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q6",
                    profficiency: .advanced,
                    question: "What is the purpose of the @Published property wrapper in Swift?",
                    answers: ["To publish a view", "To manage state in a view", "To notify observers of changes", "To handle network requests"],
                    correctAnswerIndex: 2,
                    explanation: "@Published is used to notify observers of changes to a property in a Swift class.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
                MultipleChoiceQuestion(
                    id: "q7",
                    profficiency: .basic,
                    question: "Which company developed the Swift programming language?",
                    answers: ["Google", "Microsoft", "Apple", "Facebook"],
                    correctAnswerIndex: 2,
                    explanation: "Apple developed the Swift programming language.",
                    progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository
                ),
            ],
            progressTrackingRepository: InMemoryProgressTrackingRepository.placeholderTrackingRepository,
            lesson: .placeholder
        )
    }
}

