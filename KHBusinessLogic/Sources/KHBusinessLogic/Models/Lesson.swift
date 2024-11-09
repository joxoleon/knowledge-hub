//
//  Lesson.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation
import KHContentSource

public class Lesson: Identifiable, LearningContent {

    // MARK: - Properties

    public let id: String
    public let title: String
    public let description: String
    public let tags: [String]
    public let questions: [Question]
    public let sections: [LessonSection]
    public let contentProvider: any KHDomainContentProviderProtocol

    public lazy var quiz: Quiz = {
        QuizImpl(
            id: self.id + "_quiz",
            questions: self.questions,
            contentProvider: self.contentProvider
        )
    }()

    public lazy var estimatedReadTimeSeconds: Double = {
        let lessonTextContent = sections.map { $0.content }.joined()
        return ComputationUtility.estimateReadTime(for: lessonTextContent)
    }()

    public lazy var summary: String = {
        var content = sections.last?.content ?? ""
        
        // Regular expression to match "Key takeaways" heading of any weight and any case at the start of the content
        let regex = try! NSRegularExpression(pattern: "^(#{1,6}\\s*Key takeaways\\s*)", options: [.caseInsensitive])
        content = regex.stringByReplacingMatches(in: content, options: [], range: NSRange(location: 0, length: content.utf16.count), withTemplate: "")
        
        // Add "## AAA" heading to the start of the content
        content = "## \(title)\n" + content
        
        return content
    }()

    public lazy var summaries: [String] = {
        [summary]
    }()

    public var learningContents: [any LearningContent] { [] }

    // MARK: - Initialization

    public init(
        id: String,
        title: String,
        description: String,
        sections: [LessonSection],
        questions: [Question],
        contentProvider: any KHDomainContentProviderProtocol
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.sections = sections
        self.questions = questions
        self.tags = []
        self.contentProvider = contentProvider
    }

    public init(from dtoLesson: KHContentSource.Lesson, contentProvider: any KHDomainContentProviderProtocol) {
        self.id = dtoLesson.metadata.id
        self.title = dtoLesson.metadata.title
        self.description = dtoLesson.metadata.description
        self.sections = dtoLesson.sections.map { LessonSection(from: $0) }
        self.questions = dtoLesson.questions.map { MultipleChoiceQuestion(from: $0, lessonId: dtoLesson.metadata.id, contentProvider: contentProvider ) }
        self.tags = dtoLesson.metadata.tags
        self.contentProvider = contentProvider
    }
}

public struct LessonSection: Identifiable {
    public let id: UUID = UUID()
    public let title: String
    public let content: String

    public init(content: String, title: String) {
        self.content = content
        self.title = title
    }

    public init(from dtoSection: KHContentSource.LessionContentSection) {
        self.title = dtoSection.title
        self.content = dtoSection.content
    }
}
