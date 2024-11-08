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
    private var module: LearningModule

    // MARK: - Computed Properties
    
    var startOrContinueTitle: String {
        let allContainedLessons = module.preOrderLessons
        guard !allContainedLessons.isEmpty else {
            return ""
        }
        
        // Restart
        let areAllLessonsCompleted = allContainedLessons.allSatisfy { $0.completionStatus == .completed }
        if areAllLessonsCompleted {
            return "Restart"
        }
        
        // Continue
        let hasCompleteOrInProgressLessons = allContainedLessons.contains { $0.completionStatus == .completed || $0.completionStatus == .inProgress }
        if hasCompleteOrInProgressLessons {
            return "Continue"
            
        }
        
        // Start
        return "Start"
    }
    
    // MARK: - Navigatio Destination View Models
    
    var startOrContinueLessonDetailViewModel: LessonDetailsViewModel? {
        let lessons = module.preOrderLessons
        guard !lessons.isEmpty else { return nil }
        
        if let lesson = lessons.first(where: { $0.completionStatus == .inProgress || $0.completionStatus == .notStarted }) {
            return LessonDetailsViewModel(lesson: lesson)
        }
        
        return LessonDetailsViewModel(lesson: lessons.first!)
    }

    // MARK: - Initializers
    
    init(module: LearningModule) {
        self.module = module
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: module)
        self.cellViewModels = module.learningContents.map { LearningContentMetadataViewModel(content: $0) }
    }
    
    // MARK: - Public Methods

    public func navigateToFlashcards() {
        print("Open flashcards for module")
        // TODO: Implement flashcard navigation
    }
    
    public func navigateToContent(learningContent: any LearningContent) {
        print("Navigate to content")
        // TODO: Implement navigation to content
    }
    
    public func refreshData() {
        print("*** learningModuleDetailsViewModel refreshData() ***")
        learningContentMetadataViewModel.refreshValues()
        cellViewModels.forEach { $0.refreshValues() }
    }
    
    public func quizView(isPresented: Binding<Bool>) -> some View {
        print("*** Fetching quiz from from lesson detail view model ***")
        return QuizView(viewModel: QuizViewModel(quiz: module.quiz), isPresented: isPresented)
    }
}
