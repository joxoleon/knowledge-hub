//
//  NavigationDestination.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

enum NavigationTarget: Hashable, Equatable {
    case lessonDetail(LessonDetailsViewModel)
    case moduleDetail(LearningModuleDetailsViewModel)
    case quiz(QuizViewModel)
    case flashcards
    case readLesson(LessonViewModel)
}
