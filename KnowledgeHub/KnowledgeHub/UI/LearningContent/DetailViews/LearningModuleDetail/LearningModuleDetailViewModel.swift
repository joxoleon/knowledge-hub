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

    // MARK: - Private Properties
    
    private var module: LearningModule
    private let mainTabViewModel: MainTabViewModel?
    private let privateId = UUID()

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
    
//    var startOrContinueLessonDetailViewModel: LessonDetailsViewModel? {
//        let lessons = module.preOrderLessons
//        guard let lesson = lessons.first(where: { $0.completionStatus == .inProgress || $0.completionStatus == .notStarted }) ?? lessons.first else { return nil }
//        return LessonDetailsViewModel(lesson: lesson)
//    }

    // MARK: - Initializer
    
    init(module: LearningModule, mainTabViewModel: MainTabViewModel?) {
        self.module = module
        self.mainTabViewModel = mainTabViewModel
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
        print("*** navigate to next lesson ***")
        guard let lesson = (module.preOrderLessons.first { $0.completionStatus == .notStarted }) ?? module.preOrderLessons.first else { return }
        navigateToLearningContent(content: lesson)
    }
    
    func navigateToLearningContent(content: any LearningContent) {
        if let lesson = content as? Lesson {
            let lessonDetailViewModel = LessonDetailsViewModel(lesson: lesson, mainTabViewModel: self.mainTabViewModel)
            mainTabViewModel?.navigateTo(.lessonDetail(lessonDetailViewModel))
        } else if let module = content as? LearningModule {
            let learningModuleDetailViewModel = LearningModuleDetailsViewModel(module: module, mainTabViewModel: self.mainTabViewModel)
            mainTabViewModel?.navigateTo(.moduleDetail(learningModuleDetailViewModel))
        }
    }

    func navigateToQuiz() {
//        currentNavigationTarget = .quiz
    }

    func navigateToFlashcards() {
//        currentNavigationTarget = .flashcards
    }
    
    public func quizView(isPresented: Binding<Bool>) -> some View {
        print("*** Fetching quiz from from lesson detail view model ***")
        return QuizView(viewModel: QuizViewModel(quiz: module.quiz), isPresented: isPresented)
    }
}

extension LearningModuleDetailsViewModel: Hashable, Equatable {
    static func == (lhs: LearningModuleDetailsViewModel, rhs: LearningModuleDetailsViewModel) -> Bool {
        lhs.module.id == rhs.module.id && lhs.privateId == rhs.privateId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(module.id)
        hasher.combine(privateId)
    }
}
