//
//  LearningModule.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 27.10.24..
//

import Foundation

class LearningModule: LearningContent {
    let id: LearningContentId
    let title: String
    let description: String?
    let contents: [LearningContent]
    

    init(id: LearningContentId, title: String, description: String?, contents: [LearningContent]) {
        self.id = id
        self.title = title
        self.description = description
        self.contents = contents
    }
    
    // MARK: - Learning Content Computed Properties
    
    var completionStatus: CompletionStatus {
        // TODO: - Update with recursive progress
        .notStarted
    }
}
