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
            case objectType, title, description, contents, id
        }
        
        enum ObjectType: String, Decodable {
            case module
            case lesson
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(ObjectType.self, forKey: .objectType)
            
            switch type {
            case .module:
                let title = try container.decode(String.self, forKey: .title)
                let description = try container.decode(String.self, forKey: .description)
                let contents = try container.decode([ModuleContent].self, forKey: .contents)
                self = .module(LearningModule(title: title, description: description, contents: contents))
                
            case .lesson:
                let id = try container.decode(String.self, forKey: .id)
                self = .lesson(id: id)
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .module(let module):
                try container.encode(ObjectType.module.rawValue, forKey: .objectType)
                try container.encode(module.title, forKey: .title)
                try container.encode(module.description, forKey: .description)
                try container.encode(module.contents, forKey: .contents)
                
            case .lesson(let id):
                try container.encode(ObjectType.lesson.rawValue, forKey: .objectType)
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
                return learningModule
            } catch {
                throw ModuleParsingError.yamlDecodingFailed
            }
        }
    }
}
