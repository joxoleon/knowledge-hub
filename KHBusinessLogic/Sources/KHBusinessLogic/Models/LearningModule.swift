//
//  LearningModule.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 27.10.24..
//

import Foundation
import KHContentSource

public class LearningModule: LearningContent {

    // MARK: - Properties

    public let id: String
    public let title: String
    public let description: String
    public let learningContents: [any LearningContent]
    public let progressTrackingRepository: ProgressTrackingRepository
    public lazy var quiz: any Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            progressTrackingRepository: self.progressTrackingRepository
        )
    }()

    // MARK: - Learning Content Computed Properties

    public var questions: [any Question] {
        learningContents.flatMap { content in
            content.questions
        }
    }

    // MARK: - Initialization

    public init(
        id: String, 
        title: String, 
        description: String, 
        contents: [LearningContent],
        progressTrackingRepository: ProgressTrackingRepository
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.learningContents = contents
        self.progressTrackingRepository = progressTrackingRepository
    }

    public init(from dtoModule: KHContentSource.LearningModule, contentProvider: any KHDomainContentProviderProtocol) {
        self.id = dtoModule.id
        self.title = dtoModule.title
        self.description = dtoModule.description
        self.progressTrackingRepository = contentProvider.progressTrackingRepository

        let subModules = dtoModule.subModules.map { LearningModule(from: $0, contentProvider: contentProvider) }
        let lessons: [Lesson] = dtoModule.lessons.compactMap { lessonId -> Lesson? in
            contentProvider.getLesson(by: lessonId) 
        }

        self.learningContents = subModules + lessons

    }
}
