//
//  LearningModuleDetailsViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

class LearningModuleDetailsViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var learningContentMetadataViewModel: LearningContentMetadataViewModel
    @Published var cellViewModels: [LearningContentMetadataViewModel]
    @Published var currentNavigationTarget: NavigationDestination?
    
    @Published var lessonDetailViewModel: LessonDetailsViewModel?
    @Published var learningModuleDetailViewModel: LearningModuleDetailsViewModel?

    // MARK: - Private Properties
    
    private var module: LearningModule

    // MARK: - Computed Properties
    
    var startOrContinueTitle: String {
        let allContainedLessons = module.preOrderLessons
        guard !allContainedLessons.isEmpty else { return "" }
        
        // Restart
        if allContainedLessons.allSatisfy({ $0.completionStatus == .completed }) {
            return "Restart"
        }
        
        // Continue
        if allContainedLessons.contains(where: { $0.completionStatus == .completed || $0.completionStatus == .inProgress }) {
            return "Continue"
        }
        
        // Start
        return "Start"
    }
    
    var startOrContinueLessonDetailViewModel: LessonDetailsViewModel? {
        let lessons = module.preOrderLessons
        guard let lesson = lessons.first(where: { $0.completionStatus == .inProgress || $0.completionStatus == .notStarted }) ?? lessons.first else { return nil }
        return LessonDetailsViewModel(lesson: lesson)
    }

    // MARK: - Initializer
    
    init(module: LearningModule) {
        self.module = module
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: module)
        self.cellViewModels = module.learningContents.map { LearningContentMetadataViewModel(content: $0) }
    }
    
    // MARK: - Public Methods
    
    public func refreshData() {
        print("*** learningModuleDetailsViewModel refreshData() ***")
        learningContentMetadataViewModel.refreshValues()
        cellViewModels.forEach { $0.refreshValues() }
    }
    
    // MARK: - Navigation Methods
    
    func navigateToNextLesson() {
        print("*** Navigate to next lesson invoked ***")
        guard let lesson = (module.preOrderLessons.first { $0.completionStatus == .notStarted }) ?? module.preOrderLessons.first else { return }
        print("*** Next lesson is \(lesson.title) ***")
        navigateToLearningContent(content: lesson)
    }
    
    func navigateToLearningContent(content: any LearningContent) {
        print("*** Navigate to learning content invoked for content: \(content.title) ***")
        if let lesson = content as? Lesson {
            print("*** Navigating to lesson detail view model ***")
            lessonDetailViewModel = LessonDetailsViewModel(lesson: lesson)
            currentNavigationTarget = .lessonDetail
        } else if let module = content as? LearningModule {
            print("*** Navigating to learning module detail view model ***")
            learningModuleDetailViewModel = LearningModuleDetailsViewModel(module: module)
            currentNavigationTarget = .moduleDetail
        }
    }

    func navigateToQuiz() {
        currentNavigationTarget = .quiz
    }

    func navigateToFlashcards() {
        currentNavigationTarget = .flashcards
    }
    
    public func quizView(isPresented: Binding<Bool>) -> some View {
        print("*** Fetching quiz from from lesson detail view model ***")
        return QuizView(viewModel: QuizViewModel(quiz: module.quiz), isPresented: isPresented)
    }
}
