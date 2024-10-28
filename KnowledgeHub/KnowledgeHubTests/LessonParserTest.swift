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
            #expect(Bool(false), "LessonSOLIDPrinciples.md file not found")
            return
        }

        // Attempt parsing and check the results
        do {
            let lesson = try parser.parseLesson(from: fileURL)
            
            // Assert Metadata
            #expect(lesson.id == "solid_principles", "Expected id 'solid_principles', got \(lesson.id)")
            #expect(lesson.title == "SOLID Principles for iOS Development", "Expected title 'SOLID Principles for iOS Development', got \(lesson.title)")
            #expect(lesson.description == "An in-depth lesson on the SOLID principles and their implementation in iOS development to enhance code modularity, maintainability, and scalability.", "Unexpected description")

            // Assert Sections
            #expect(lesson.sections.count == 4, "Expected 4 sections, got \(lesson.sections.count)")
            #expect(lesson.sections[0].title == "SOLID Principles Introduction", "Unexpected title for section 1")
            #expect(lesson.sections[1].title == "SOLID Principles", "Unexpected title for section 2")
            #expect(lesson.sections[2].title == "Discussion", "Unexpected title for section 3")
            #expect(lesson.sections[3].title == "Key Takeaways", "Unexpected title for section 4")
            
            // Assert Questions
            #expect(lesson.questions.count == 5, "Expected 5 questions, got \(lesson.questions.count)")
            
            // Check specific fields for each question
            #expect(lesson.questions[0].id == "solid_principles_q1", "Unexpected question ID for question 1")
            #expect(lesson.questions[0].type == "multiple_choice", "Unexpected question type for question 1")
            #expect(lesson.questions[0].proficiency == "basic", "Unexpected proficiency for question 1")
            #expect(lesson.questions[0].question == "What does the Single Responsibility Principle (SRP) state?", "Unexpected question text for question 1")
            #expect(lesson.questions[0].correctAnswerIndex == 0, "Unexpected correct answer index for question 1")
            #expect(lesson.questions[0].explanation == "SRP specifies that a class should have only one responsibility, which simplifies testing and maintenance.", "Unexpected explanation for question 1")

            // Example for question 2
            #expect(lesson.questions[1].id == "solid_principles_q2", "Unexpected question ID for question 2")
            #expect(lesson.questions[1].type == "multiple_choice", "Unexpected question type for question 2")
            #expect(lesson.questions[1].proficiency == "intermediate", "Unexpected proficiency for question 2")
            #expect(lesson.questions[1].question == "Which SOLID principle helps in extending code without modifying it?", "Unexpected question text for question 2")
            #expect(lesson.questions[1].correctAnswerIndex == 1, "Unexpected correct answer index for question 2")
            #expect(lesson.questions[1].explanation == "OCP allows code to be extended by creating new classes or methods rather than altering existing ones.", "Unexpected explanation for question 2")

        } catch {
            #expect(Bool(false), "Parsing failed with error: \(error)")
        }
    }
    
    @Test func testLessonParsingMVVMArchitecture() async throws {
            // Locate the test resource in the bundle
            let testBundle = Bundle(for: TestBundleHelper.self)
            guard let fileURL = testBundle.url(forResource: "LessonMVVM", withExtension: "md") else {
                #expect(Bool(false), "LessonMVVM.md file not found")
                return
            }

            // Attempt parsing and check the results
            do {
                let lesson = try parser.parseLesson(from: fileURL)
                
                // Assert Metadata
                #expect(lesson.id == "mvvm_architecture_ios", "Expected id 'mvvm_architecture_ios', got \(lesson.id)")
                #expect(lesson.title == "MVVM Architecture for iOS Development using SwiftUI", "Expected title 'MVVM Architecture for iOS Development using SwiftUI', got \(lesson.title)")
                #expect(lesson.description == "An introductory lesson on MVVM architecture and how to implement it in iOS development with SwiftUI, covering key components, benefits, and implementation examples.", "Unexpected description")

                // Assert Sections
                #expect(lesson.sections.count == 4, "Expected 4 sections, got \(lesson.sections.count)")
                #expect(lesson.sections[0].title == "MVVM Architecture for iOS Development using SwiftUI Introduction", "Unexpected title for section 1")
                #expect(lesson.sections[1].title == "MVVM Architecture for iOS Development using SwiftUI", "Unexpected title for section 2")
                #expect(lesson.sections[2].title == "Discussion", "Unexpected title for section 3")
                #expect(lesson.sections[3].title == "Key Takeaways", "Unexpected title for section 4")
                
                // Assert Questions
                #expect(lesson.questions.count == 5, "Expected 5 questions, got \(lesson.questions.count)")
                
                // Check specific fields for each question
                #expect(lesson.questions[0].id == "mvvm_architecture_ios_q1", "Unexpected question ID for question 1")
                #expect(lesson.questions[0].type == "multiple_choice", "Unexpected question type for question 1")
                #expect(lesson.questions[0].proficiency == "basic", "Unexpected proficiency for question 1")
                #expect(lesson.questions[0].question == "In the MVVM pattern, which component is responsible for managing business logic?", "Unexpected question text for question 1")
                #expect(lesson.questions[0].correctAnswerIndex == 1, "Unexpected correct answer index for question 1")
                #expect(lesson.questions[0].explanation == "The ViewModel holds business logic, keeping the View focused solely on UI presentation.", "Unexpected explanation for question 1")

                // Example for question 2
                #expect(lesson.questions[1].id == "mvvm_architecture_ios_q2", "Unexpected question ID for question 2")
                #expect(lesson.questions[1].type == "multiple_choice", "Unexpected question type for question 2")
                #expect(lesson.questions[1].proficiency == "intermediate", "Unexpected proficiency for question 2")
                #expect(lesson.questions[1].question == "Which property wrapper in SwiftUI helps observe changes in the ViewModel?", "Unexpected question text for question 2")
                #expect(lesson.questions[1].correctAnswerIndex == 0, "Unexpected correct answer index for question 2")
                #expect(lesson.questions[1].explanation == "The @StateObject property wrapper creates and owns an instance of the ViewModel, observing changes for reactive UI updates.", "Unexpected explanation for question 2")

            } catch {
                #expect(Bool(false), "Parsing failed with error: \(error)")
            }
        }
}
