//
//  LearningModule.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 27.10.24..
//

import Foundation

class LearningModule: LearningContent {
    let id: String
    let title: String
    let description: String?
    let contents: [LearningContent]
    let progressTrackingRepository: ProgressTrackingRepository
    
    // MARK: - Initialization

    init(id: String, title: String, description: String?, contents: [LearningContent], progressTrackingRepository: ProgressTrackingRepository) {
        self.id = id
        self.title = title
        self.description = description
        self.contents = contents
        self.progressTrackingRepository = progressTrackingRepository
    }
    
    // MARK: - Learning Content Computed Properties
    
    var completionStatus: CompletionStatus {
        // TODO: - Update with recursive progress
        .notStarted
    }
    
    var questions: [any Question] {
        contents.flatMap { content in
            content.questions
        }
    }
    
    lazy var quiz: any Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            progressTrackingRepository: self.progressTrackingRepository
        )
    }()
}
