//
//  LessonViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation

class LessonViewModel: ObservableObject {
    @Published var lesson: Lesson
    @Published var colorManager: ColorManager

    init(lesson: Lesson, colorManager: ColorManager) {
        self.lesson = lesson
        self.colorManager = colorManager
    }

    var sections: [LessonSection] {
        lesson.sections
    }
}
