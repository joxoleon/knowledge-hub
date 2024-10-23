//
//  Lesson.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation

struct Lesson: Identifiable {
    let id: UUID
    let title: String
    let sections: [LessonSection]
    
    init(id: UUID = UUID(), title: String, sections: [LessonSection]) {
        self.id = id
        self.title = title
        self.sections = sections
    }
}

struct LessonSection: Identifiable {
    let id: UUID
    let content: String // In Markdown
    
    init(id: UUID = UUID(), content: String) {
        self.id = id
        self.content = content
    }
}
