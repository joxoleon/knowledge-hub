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
    public let contentProvider: any KHDomainContentProviderProtocol

    public lazy var quiz: any Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            contentProvider: self.contentProvider
        )
    }()

    public lazy var estimatedReadTimeSeconds: Double = {
        learningContents.reduce(0) { $0 + $1.estimatedReadTimeSeconds }
    }()

    public lazy var summaries: [String] = {
        preOrderLessons.map { $0.summary }
    }()

    public lazy var tags: [String] = {
        let allTags = learningContents.flatMap { content in
            content.tags
        }
        // Remove duplicates
        return Array(Set(allTags))
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
        contentProvider: any KHDomainContentProviderProtocol
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.learningContents = contents
        self.contentProvider = contentProvider
    }

    public init(from dtoModule: KHContentSource.LearningModule, contentProvider: any KHDomainContentProviderProtocol) {
        self.id = dtoModule.id
        self.title = dtoModule.title
        self.description = dtoModule.description
        self.contentProvider = contentProvider
    
        // Convert submodules to LearningModule instances
        let subModules = dtoModule.subModules.map { LearningModule(from: $0, contentProvider: contentProvider) }
    
        // Convert lesson IDs to Lesson instances, filtering out any nil results
        let lessons = dtoModule.lessons.compactMap { contentProvider.getLesson(by: $0) }
    
        // Combine submodules and lessons into learningContents
        self.learningContents = subModules + lessons
    }
}
