//
//  LessonViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation
import KHBusinessLogic

class LessonViewModel: ObservableObject {
    @Published var lesson: Lesson

    init(lesson: Lesson) {
        print("*** Instantiating lesson view model")
        self.lesson = lesson
    }

    var sections: [LessonSection] {
        lesson.sections
    }
}
