import XCTest
@testable import KHBusinessLogic

final class TestKHDomainContentProviderUsageTests: XCTestCase {

    func testContentProviderBasicOperations() {
        let contentProvider = TestingKHDomainContentProvider()
        
        // Fetch top level modules
        let topLevelModules = contentProvider.getTopLevelModules()
        XCTAssertFalse(topLevelModules.isEmpty, "Top level modules should not be empty")
        
        // Fetch a lesson by ID
        let lessonId = "solid_principles_for_ios_development"
        guard let lesson = contentProvider.getLesson(by: lessonId) else {
            XCTFail("Lesson with ID \(lessonId) should exist")
            return
        }

        // Verify active top module
        let activeTopModule = contentProvider.activeTopModule
        XCTAssertEqual(activeTopModule.title, "Software Design Principles", "Active top module title should match")
        
        // Print module composite data
        print("Active Top Module: \(activeTopModule.title)")
        print("Active Top Module Description: \(activeTopModule.description)")
        print("Active Top Module Estimated Read Time: \(activeTopModule.estimatedReadTimeSeconds) seconds")
        
        // Test active top module quiz
        let quiz = activeTopModule.quiz
        XCTAssertEqual(quiz.questions.count, 5, "Active top module quiz should have 5 questions")
        
        // Print lesson details
        print("Lesson Title: \(lesson.title)")
        print("Lesson Description: \(lesson.description)")
        
        // Verify lesson content
        XCTAssertEqual(lesson.title, "SOLID Principles for iOS Development", "Lesson title should match")
        XCTAssertEqual(lesson.sections.count, 4, "Lesson should have 4 sections")
        XCTAssertEqual(lesson.questions.count, 5, "Lesson should have 5 questions")
    }
}
