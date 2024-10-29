//
//  KHLearningModuleParser.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 28.10.24..
//

import Foundation
import Yams

// KHContentSource namespace
extension KHContentSource {

    // MARK: - Types
    
    public struct LearningModule: Codable {
        let title: String
        let description: String
        let contents: [ModuleContent]
    }
    
    public enum ModuleContent: Codable {
        case module(LearningModule)
        case lesson(id: String)
        
        enum CodingKeys: String, CodingKey {
            case title, description, contents, id
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Determine whether this content is a `module` or `lesson`
            if container.contains(.title) && container.contains(.description) && container.contains(.contents) {
                // Decode as a module
                let title = try container.decode(String.self, forKey: .title)
                let description = try container.decode(String.self, forKey: .description)
                let contents = try container.decode([ModuleContent].self, forKey: .contents)
                self = .module(LearningModule(title: title, description: description, contents: contents))
                
            } else if container.contains(.id) {
                // Decode as a lesson
                let id = try container.decode(String.self, forKey: .id)
                self = .lesson(id: id)
                
            } else {
                // Handle decoding error with meaningful context
                throw DecodingError.dataCorruptedError(
                    forKey: .title,
                    in: container,
                    debugDescription: "Invalid structure: Expected either a 'module' with 'title', 'description', and 'contents' or a 'lesson' with 'id'."
                )
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .module(let module):
                try container.encode(module.title, forKey: .title)
                try container.encode(module.description, forKey: .description)
                try container.encode(module.contents, forKey: .contents)
                
            case .lesson(let id):
                try container.encode(id, forKey: .id)
            }
        }
    }

    enum ModuleParsingError: Error {
        case fileNotFound
        case invalidContent
        case yamlDecodingFailed
    }
    
    // MARK: - LearningModuleParser
    
    class LearningModuleParser {
        
        func parseLearningModule(from fileURL: URL) throws -> LearningModule {
            let yamlContent = try String(contentsOf: fileURL)
            
            // Debug: Print the YAML content to see what is being parsed
            print("YAML Content:\n\(yamlContent)")
            
            guard let learningModule = try decodeYAML(yamlContent) else {
                throw ModuleParsingError.invalidContent
            }
            
            return learningModule
        }
        
        // MARK: - YAML Decoding
        
        private func decodeYAML(_ yamlContent: String) throws -> LearningModule? {
            let decoder = YAMLDecoder()
            do {
                let learningModule = try decoder.decode(LearningModule.self, from: yamlContent)
                
                // Debug: Print the decoded structure to verify correctness
                print("Decoded LearningModule:\n\(learningModule)")
                
                return learningModule
            } catch {
                // Debug: Print error details to understand the decoding failure
                print("Decoding Error: \(error)")
                throw ModuleParsingError.yamlDecodingFailed
            }
        }
    }
}
