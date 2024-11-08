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
    
    private var privateId = UUID()

    init(lesson: Lesson) {
        print("*** Instantiating lesson view model")
        self.lesson = lesson
    }

    var sections: [LessonSection] {
        lesson.sections
    }
}

extension LessonViewModel: Hashable, Equatable {
    static func == (lhs: LessonViewModel, rhs: LessonViewModel) -> Bool {
        lhs.lesson.id == rhs.lesson.id && lhs.privateId == rhs.privateId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(lesson.id)
        hasher.combine(privateId)
    }
}
