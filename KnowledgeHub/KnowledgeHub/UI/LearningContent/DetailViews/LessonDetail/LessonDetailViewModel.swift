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

    func flashCardsView(isPresented: Binding<Bool>) -> some View {
        return FlashCardView(cards: lesson.summaries, isPresented: isPresented)
    }
    
    public func navigateToPreviousLesson() {
        guard let previousLesson = getPreviousLesson else { return }
        // TODO: Handle this in a much better way!
        lesson = previousLesson
        learningContentMetadataViewModel.content = previousLesson
        refreshValues()
    }
    
    public func navigateToNextLesson() {
        guard let nextLesson = getNextLesson else { return }
        lesson = nextLesson
        learningContentMetadataViewModel.content = nextLesson
        refreshValues()
    }
    
    public func refreshValues() {
        learningContentMetadataViewModel.refreshValues()
    }
    
    private var getNextLesson: Lesson? {
        let allLessons = lesson.contentProvider.activeTopModule.preOrderLessons
        guard let currentIndex = allLessons.firstIndex(where: { $0.id == lesson.id }) else { return nil }
        let nextIndex = (currentIndex + 1) % allLessons.count
        return allLessons[nextIndex]
    }
    
    private var getPreviousLesson: Lesson? {
        let allLessons = lesson.contentProvider.activeTopModule.preOrderLessons
        guard let currentIndex = allLessons.firstIndex(where: { $0.id == lesson.id }) else { return nil }
        let previousIndex = (currentIndex - 1 + allLessons.count) % allLessons.count
        return allLessons[previousIndex]
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
