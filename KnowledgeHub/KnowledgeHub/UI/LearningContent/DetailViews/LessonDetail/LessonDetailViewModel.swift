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
    private let mainTabViewModel: MainTabViewModel?
    private let privateId = UUID()

    // MARK: - Initializers
    
    init(lesson: Lesson, mainTabViewModel: MainTabViewModel?) {
        self.lesson = lesson
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: lesson)
        self.mainTabViewModel = mainTabViewModel
    }
    
    // MARK: - Public Methods
    
    func readLessonView(isPresented: Binding<Bool>) -> some View {
        print("*** Fetching read lesson from lesson detail view model ***")
        return ReadLessonView(viewModel: LessonViewModel(lesson: lesson), isPresented: isPresented)
    }
    
    func quizView(isPresented: Binding<Bool>) -> some View {
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

extension LessonDetailsViewModel: Hashable, Equatable {
    static func == (lhs: LessonDetailsViewModel, rhs: LessonDetailsViewModel) -> Bool {
        lhs.lesson.id == rhs.lesson.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(lesson.id)
        hasher.combine(privateId)
    }
}
