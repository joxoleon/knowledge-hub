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
    @State var isReadLessonPresented = false
    
    // MARK: - Private Properties
    
    private var lesson: Lesson

    // MARK: - Initializers
    
    init(lesson: Lesson) {
        self.lesson = lesson
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: lesson)
    }
    
    // MARK: - Public Methods
    
    func readLessonView(isPresented: Binding<Bool>) -> some View {
        ReadLessonView(viewModel: LessonViewModel(lesson: lesson), isPresented: isPresented)
    }

    public func navigateToReadLesson() {
        print("*** Navigate to read lesson ***")
        isReadLessonPresented = true
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

