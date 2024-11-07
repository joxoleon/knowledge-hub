//
//  LessonDetailViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

class LessonDetailsViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var learningContentMetadataViewModel: LearningContentMetadataViewModel
    
    // MARK: - Private Properties
    
    private var lesson: Lesson

    // MARK: - Initializers
    
    init(lesson: Lesson) {
        self.lesson = lesson
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: lesson)
    }
    
    // MARK: - Public Methods

    public func navigateToReadLesson() {
        print("Read lesson")
        // TODO: Implement navigation
    }

    public func navigateToQuiz() {
        print("Start quiz")
        // TODO: Implement navigation
    }

    public func navigateToFlashcards() {
        print("FLASH ME!")
        // TODO: Implement navigation
    }
    
    public func navigateToPreviousLesson() {
        print("Previous lesson")
    }
    
    public func navigateToNextLesson() {
        print("Next lesson")
    }
}

