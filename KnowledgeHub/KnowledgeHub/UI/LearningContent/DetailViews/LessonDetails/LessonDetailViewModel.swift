//
//  LessonDetailViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

class LessonDetailsViewModel: LearningContentMetadataViewModel {
    private var lesson: Lesson

    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(content: lesson)
    }

    func navigateToReadLesson() {
        print("Read lesson")
        // TODO: Implement navigation
    }

    func navigateToQuiz() {
        print("Start quiz")
        // TODO: Implement navigation
    }

    func navigateToFlashcards() {
        print("FLASH ME!")
        // TODO: Implement navigation
    }
}

