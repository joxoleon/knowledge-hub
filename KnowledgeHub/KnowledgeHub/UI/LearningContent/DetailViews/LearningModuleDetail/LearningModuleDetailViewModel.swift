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
    @Published var contentListViewModel: LearningContentListViewModel
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
        self.contentListViewModel = LearningContentListViewModel(learningContents: module.learningContents)
    }
    
    // MARK: - Public Methods

    public func startOrContinueLearning() {
        print("Start or continue learning")
        // TODO: Implement navigation or continue action
    }

    public func navigateToQuiz() {
        print("Start quiz for module")
        // TODO: Implement quiz navigation
    }

    public func navigateToFlashcards() {
        print("Open flashcards for module")
        // TODO: Implement flashcard navigation
    }
    
    public func navigateToContent(learningContent: any LearningContent) {
        print("Navigate to content")
        // TODO: Implement navigation to content
    }
}
