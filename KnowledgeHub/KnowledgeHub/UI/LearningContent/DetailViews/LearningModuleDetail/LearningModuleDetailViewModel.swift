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

    // Computed property for Start/Continue button title
    var startOrContinueTitle: String {
        // TODO: Implement business logic to determine for continuation
        "Continue"
    }

    // MARK: - Initializers
    
    init(module: LearningModule) {
        self.module = module
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: module)
        self.cellViewModels = module.learningContents.map { LearningContentMetadataViewModel(content: $0) }
    }
    
    // MARK: - Public Methods

    public func startOrContinueLearning() {
        print("Start or continue learning")
        // TODO: Implement navigation or continue action
    }

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
