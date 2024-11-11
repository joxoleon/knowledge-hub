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
    
    // MARK: - Initializer
    
    init(module: LearningModule, mainTabViewModel: MainTabViewModel?) {
        self.module = module
        self.mainTabViewModel = mainTabViewModel
        self.learningContentMetadataViewModel = LearningContentMetadataViewModel(content: module)
        self.cellViewModels = module.learningContents.map { LearningContentMetadataViewModel(content: $0) }
    }
    
    // MARK: - Public Methods
    
    func quizView(isPresented: Binding<Bool>) -> some View {
        return QuizView(viewModel: QuizViewModel(quiz: module.quiz), isPresented: isPresented)
    }
    
    func flashCardsView(isPresented: Binding<Bool>) -> some View {
        return FlashCardView(cards: module.summaries, isPresented: isPresented)
    }
    
    public func refreshData() {
        print("*** learningModuleDetailsViewModel refreshData() ***")
        learningContentMetadataViewModel.refreshValues()
        cellViewModels.forEach { $0.refreshValues() }
    }
    
    // MARK: - Navigation Methods
    
    func navigateToNextLesson() {
        print("*** navigate to next lesson ***")
        guard let lesson = (module.preOrderLessons.first { $0.completionStatus == .notStarted }) ?? module.preOrderLessons.first else { return }
        mainTabViewModel?.navigateToLearningContent(content: lesson)
    }
    
    func navigateToLearningContent(content: any LearningContent) {
        mainTabViewModel?.navigateToLearningContent(content: content)
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
