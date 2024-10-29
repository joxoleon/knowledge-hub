//
//  ModuleParserTest.swift
//  KnowledgeHubTests
//
//  Created by Jovan Radivojsa on 29.10.24..
//

import Foundation
import Testing
@testable import KnowledgeHub

// Dummy class to help get the test bundle
private class TestBundleHelper {}

struct LearningModuleParserTest {
    
    let parser = KHContentSource.LearningModuleParser()
    
    @Test func testLearningModuleParsing() async throws {
        // Locate the test resource in the bundle
        let testBundle = Bundle(for: TestBundleHelper.self)
        guard let fileURL = testBundle.url(forResource: "LearningModule", withExtension: "yaml") else {
            #expect(Bool(false), "LearningModule.yaml file not found")
            return
        }

        // Attempt parsing and check the results
        do {
            let learningModule = try parser.parseLearningModule(from: fileURL)
            
            // Assert LearningModule Metadata
            #expect(learningModule.title == "iOS Interview Preparation", "Expected title 'iOS Interview Preparation', got \(learningModule.title)")
            #expect(learningModule.description == "An extensive overview of essential iOS development knowledge, designed to prepare you thoroughly for iOS interview success.", "Unexpected description")
            
            // Assert Top-Level Contents
            #expect(learningModule.contents.count == 2, "Expected 2 top-level contents, got \(learningModule.contents.count)")
            
            // Check first module's metadata (Swift Programming Language)
            if case let .module(swiftModule) = learningModule.contents[0] {
                #expect(swiftModule.title == "Swift Programming Language", "Expected title 'Swift Programming Language', got \(swiftModule.title)")
                #expect(swiftModule.description == "Comprehensive insights into the Swift programming language, covering foundational to advanced concepts critical for iOS development.", "Unexpected description")
                
                // Check contents of Swift Programming Language module
                #expect(swiftModule.contents.count == 3, "Expected 3 contents in Swift Programming Language module, got \(swiftModule.contents.count)")
                
                // Verify nested module (Fundamental Swift Concepts)
                if case let .module(fundamentalModule) = swiftModule.contents[0] {
                    #expect(fundamentalModule.title == "Fundamental Swift Concepts", "Expected title 'Fundamental Swift Concepts', got \(fundamentalModule.title)")
                    #expect(fundamentalModule.description == "Covers basic Swift language constructs and types, essential for building a solid programming foundation.", "Unexpected description")
                    
                    // Verify lessons within Fundamental Swift Concepts module
                    #expect(fundamentalModule.contents.count == 3, "Expected 3 lessons in Fundamental Swift Concepts module, got \(fundamentalModule.contents.count)")
                    
                    if case let .lesson(lessonID) = fundamentalModule.contents[0] {
                        #expect(lessonID == "types_overview", "Expected lesson id 'types_overview', got \(lessonID)")
                    }
                    if case let .lesson(lessonID) = fundamentalModule.contents[1] {
                        #expect(lessonID == "optionals_basics", "Expected lesson id 'optionals_basics', got \(lessonID)")
                    }
                    if case let .lesson(lessonID) = fundamentalModule.contents[2] {
                        #expect(lessonID == "basic_control_flow", "Expected lesson id 'basic_control_flow', got \(lessonID)")
                    }
                }
                
                // Verify nested module (Intermediate Swift Concepts)
                if case let .module(intermediateModule) = swiftModule.contents[1] {
                    #expect(intermediateModule.title == "Intermediate Swift Concepts", "Expected title 'Intermediate Swift Concepts', got \(intermediateModule.title)")
                    #expect(intermediateModule.description == "Explores intermediate features in Swift such as structures, classes, and protocols that are core to app development.", "Unexpected description")
                    
                    // Verify lessons within Intermediate Swift Concepts module
                    #expect(intermediateModule.contents.count == 3, "Expected 3 lessons in Intermediate Swift Concepts module, got \(intermediateModule.contents.count)")
                    
                    if case let .lesson(lessonID) = intermediateModule.contents[0] {
                        #expect(lessonID == "classes_and_structs", "Expected lesson id 'classes_and_structs', got \(lessonID)")
                    }
                    if case let .lesson(lessonID) = intermediateModule.contents[1] {
                        #expect(lessonID == "protocols_and_delegation", "Expected lesson id 'protocols_and_delegation', got \(lessonID)")
                    }
                    if case let .lesson(lessonID) = intermediateModule.contents[2] {
                        #expect(lessonID == "error_handling", "Expected lesson id 'error_handling', got \(lessonID)")
                    }
                }
            }
            
            // Check second module's metadata (Software Architectures and Design Patterns for iOS)
            if case let .module(architectureModule) = learningModule.contents[1] {
                #expect(architectureModule.title == "Software Architectures and Design Patterns for iOS", "Expected title 'Software Architectures and Design Patterns for iOS', got \(architectureModule.title)")
                #expect(architectureModule.description == "A deep dive into essential software architectures and design patterns used in iOS for scalable and maintainable applications.", "Unexpected description")
                
                // Verify contents in Software Architectures and Design Patterns for iOS
                #expect(architectureModule.contents.count == 3, "Expected 3 contents in Software Architectures module, got \(architectureModule.contents.count)")
                
                // Verify nested module (MVC)
                if case let .module(mvcModule) = architectureModule.contents[0] {
                    #expect(mvcModule.title == "Model-View-Controller (MVC)", "Expected title 'Model-View-Controller (MVC)', got \(mvcModule.title)")
                    #expect(mvcModule.description == "Introduction to the MVC pattern, the foundation of many iOS applications, and best practices for its use.", "Unexpected description")
                    
                    // Verify lessons within MVC module
                    #expect(mvcModule.contents.count == 2, "Expected 2 lessons in MVC module, got \(mvcModule.contents.count)")
                    
                    if case let .lesson(lessonID) = mvcModule.contents[0] {
                        #expect(lessonID == "mvc_overview", "Expected lesson id 'mvc_overview', got \(lessonID)")
                    }
                    if case let .lesson(lessonID) = mvcModule.contents[1] {
                        #expect(lessonID == "mvc_implementation_examples", "Expected lesson id 'mvc_implementation_examples', got \(lessonID)")
                    }
                }
            }
            
        } catch {
            #expect(Bool(false), "Parsing failed with error: \(error)")
        }
    }
}
