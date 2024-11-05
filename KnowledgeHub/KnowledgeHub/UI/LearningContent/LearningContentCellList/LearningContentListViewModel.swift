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
    @Published var learningContents: [any LearningContent] = []

    private var cancellables = Set<AnyCancellable>()
    
    init(learningContents: [any LearningContent]) {
        self.learningContents = learningContents
    }
}
