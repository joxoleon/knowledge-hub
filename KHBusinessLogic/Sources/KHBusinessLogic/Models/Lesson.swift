//
//  Lesson.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation

class Lesson: Identifiable, LearningContent {
    let id: String
    let title: String
    let description: String?
    let sections: [LessonSection]
    let questions: [Question]
    
    // MARK: - Learning Content Computed Properties
    
    lazy var quiz: Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            progressTrackingRepository: self.quiz.progressTrackingRepository
        )
    }()
    
    // MARK: - Initialization
    
    init(
        id: String,
        title: String,
        description: String? = nil,
        sections: [LessonSection],
        questions: [Question]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.sections = sections
        self.questions = questions
    }
}

struct LessonSection: Identifiable {
    let id: UUID = UUID()
    let content: String // In Markdown
}