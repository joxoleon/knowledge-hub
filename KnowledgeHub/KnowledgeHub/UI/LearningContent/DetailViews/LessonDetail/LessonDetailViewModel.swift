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
    
    func readLessonView(isPresented: Binding<Bool>) -> some View {
        print("*** Fetching read lesson from lesson detail view model ***")
        return ReadLessonView(viewModel: LessonViewModel(lesson: lesson), isPresented: isPresented)
    }
    
    func quizView(isPresented: Binding<Bool>) -> some View {
        print("*** Fetching quiz from from lesson detail view model ***")
        return QuizView(viewModel: QuizViewModel(quiz: lesson.quiz), isPresented: isPresented)
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
    
    public func refreshValues() {
        learningContentMetadataViewModel.refreshValues()
    }
}

