//
//  LessonParserTest.swift
//  KnowledgeHubTests
//
//  Created by Jovan Radivojsa on 28.10.24..
//

import Foundation
import Testing
@testable import KnowledgeHub

// Dummy class to help get the test bundle
private class TestBundleHelper {}

struct LessonParserTest {
    
    let parser = KHContentSource.LessonParser()
    
    @Test func testLessonParsingSOLIDPrinciples() async throws {
        // Locate the test resource in the bundle
        let testBundle = Bundle(for: TestBundleHelper.self)
         guard let fileURL = testBundle.url(forResource: "LessonSOLIDPrinciples", withExtension: "md") else {
             #expect(false, "LessonSOLIDPrinciples.md file not found")
             return
         }

        // Attempt parsing and check the results
        do {
            let lesson = try parser.parseLesson(from: fileURL)
            
            // Assert Metadata
            #expect(lesson.id == "solid_principles", "Expected id 'solid_principles', got \(lesson.id)")
            #expect(lesson.title == "SOLID Principles for iOS Development", "Expected title 'SOLID Principles for iOS Development', got \(lesson.title)")
            #expect(lesson.description == "An overview of SOLID principles and their application in iOS development.", "Unexpected description")

            // Assert Sections
            #expect(lesson.sections.count == 4, "Expected 4 sections, got \(lesson.sections.count)")
            #expect(lesson.sections[0].title == "Definition and Introduction", "Unexpected title for section 1")
            #expect(lesson.sections[1].title == "Single Responsibility Principle", "Unexpected title for section 2")
            #expect(lesson.sections[2].title == "Open-Closed Principle", "Unexpected title for section 3")
            #expect(lesson.sections[3].title == "Key Takeaways", "Unexpected title for section 4")
            #expect(lesson.sections[0].content.contains("SOLID is an acronym for five design principles..."), "Introduction content missing expected text")

            // Assert Questions
            #expect(lesson.questions.count == 5, "Expected 5 questions, got \(lesson.questions.count)")
            #expect(lesson.questions[0].id == "solid_principles_q1", "Unexpected question ID for question 1")
            #expect(lesson.questions[0].type == "multiple_choice", "Unexpected question type for question 1")
            #expect(lesson.questions[0].proficiency == "basic", "Unexpected proficiency for question 1")
            #expect(lesson.questions[0].question == "What is the main goal of the Single Responsibility Principle?", "Unexpected question text for question 1")
            #expect(lesson.questions[0].answers.count == 4, "Expected 4 answers for question 1, got \(lesson.questions[0].answers.count)")
            #expect(lesson.questions[0].correctAnswerIndex == 1, "Unexpected correct answer index for question 1")
            #expect(lesson.questions[0].explanation.contains("The Single Responsibility Principle..."), "Explanation for question 1 missing expected text")
            
        } catch {
            #expect(false, "Parsing failed with error: \(error)")
        }
    }
}

