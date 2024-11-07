//
//  LearningContentListViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import Foundation
import KHBusinessLogic
import Combine

class LearningContentListViewModel: ObservableObject {
    @Published var cellViewModels: [LearningContentMetadataViewModel] = []
    private var learningContents: [any LearningContent]
    private var cancellables = Set<AnyCancellable>()

    init(learningContents: [any LearningContent]) {
        self.learningContents = learningContents
        self.cellViewModels = learningContents.map { LearningContentMetadataViewModel(content: $0) }
    }
}
