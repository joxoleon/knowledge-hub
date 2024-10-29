//
//  LearningModuleParserTest.swift
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
            
            // Assert Top-Level LearningModule Metadata
            #expect(learningModule.title == "iOS Interview Preparation", "Expected title 'iOS Interview Preparation', got \(learningModule.title)")
            #expect(learningModule.description == "An extensive overview of essential iOS development knowledge, designed to prepare you thoroughly for iOS interview success.", "Unexpected description")
            #expect(learningModule.subModules.count == 2, "Expected 2 top-level sub-modules, got \(learningModule.subModules.count)")
        } catch {
            #expect(Bool(false), "Parsing failed with error: \(error)")
        }
    }
}
