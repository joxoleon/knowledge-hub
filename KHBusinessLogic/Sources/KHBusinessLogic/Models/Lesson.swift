//
//  Lesson.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation

class Lesson: Identifiable, LearningContent {

    // MARK: - Properties

    let id: String
    let title: String
    let description: String
    let questions: [Question]
    let sections: [LessonSection]

    // MARK: - Services

    let progressTrackingRepository: any ProgressTrackingRepository

    // MARK: - Learning Content Computed Properties

    lazy var quiz: Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            progressTrackingRepository: self.progressTrackingRepository
        )
    }()

    // MARK: - Initialization

    init(
        id: String,
        title: String,
        description: String,
        sections: [LessonSection],
        questions: [Question],
        progressTrackingRepository: any ProgressTrackingRepository
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.sections = sections
        self.questions = questions
        self.progressTrackingRepository = progressTrackingRepository
    }
}

struct LessonSection: Identifiable {
    let id: UUID = UUID()
    let content: String  // In Markdown
}
