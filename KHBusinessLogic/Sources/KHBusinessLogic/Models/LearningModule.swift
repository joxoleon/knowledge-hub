//
//  LearningModule.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 27.10.24..
//

import Foundation

class LearningModule: LearningContent {

    // MARK: - Properties

    let id: String
    let title: String
    let description: String
    let contents: [LearningContent]
    let progressTrackingRepository: ProgressTrackingRepository
    lazy var quiz: any Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            progressTrackingRepository: self.progressTrackingRepository
        )
    }()

    // MARK: - Learning Content Computed Properties

    var questions: [any Question] {
        contents.flatMap { content in
            content.questions
        }
    }

    // MARK: - Initialization

    init(
        id: String, 
        title: String, 
        description: String, 
        contents: [LearningContent],
        progressTrackingRepository: ProgressTrackingRepository
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.contents = contents
        self.progressTrackingRepository = progressTrackingRepository
    }
}
