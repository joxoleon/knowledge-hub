import Foundation
import Yams

// KHContentSource namespace
extension KHContentSource {

    // MARK: - Types
    
    public struct LearningModule: Codable {
        let id: String
        let title: String
        let description: String
        let subModules: [LearningModule]
        let lessons: [String]
        
        enum CodingKeys: String, CodingKey {
            case title, description, subModules, lessons
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            id = title.replacingOccurrences(of: " ", with: "_").lowercased()
            description = try container.decode(String.self, forKey: .description)
            subModules = try container.decodeIfPresent([LearningModule].self, forKey: .subModules) ?? []
            lessons = try container.decodeIfPresent([String].self, forKey: .lessons) ?? []
        }
    }
    
    public enum ModuleParsingError: Error {
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
