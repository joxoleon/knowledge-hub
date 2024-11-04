//
//  TestingUtility.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 4.11.24..
//

import Foundation
import KHBusinessLogic

enum Testing {
    
    public static var contentProvider = TestingKHDomainContentProvider()
    
    public static var testLesson: Lesson = {
        contentProvider.activeTopModule.preOrderLessons.first!
    }()
    
    public static var testQuiz: Quiz = {
        contentProvider.activeTopModule.quiz
    }()
}
