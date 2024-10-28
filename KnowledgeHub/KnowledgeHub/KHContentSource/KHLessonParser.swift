//
//  KHLessonParser.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 28.10.24..
//

import Foundation

// KHContentSource namespace
enum KHContentSource {
    struct Lesson {
        var id: String
        var title: String
        var description: String
        var sections: [Section]
        var questions: [Question]
    }

    struct Section {
        var title: String
        var content: String
    }

    struct Question: Codable {
        var id: String
        var type: String
        var proficiency: String
        var question: String
        var answers: [String]
        var correctAnswerIndex: Int
        var explanation: String
    }

    enum ParsingError: Error {
        case missingMetadata
        case invalidSection
    }
    
    class LessonParser {
        
        private let metadataStartDelimiter = "{"
        private let metadataEndDelimiter = "}"
        
        func parseLesson(from fileURL: URL) throws -> Lesson {
            let content = try String(contentsOf: fileURL)
            var sections: [Section] = []
            var questions: [Question] = []
            
            // Step 1: Parse Metadata
            guard let metadata = parseMetadata(in: content) else {
                throw ParsingError.missingMetadata
            }
            
            // Step 2: Parse Sections
            sections = parseSections(in: content)
            
            // Step 3: Parse Questions
            if let questionsData = extractQuestionsData(from: content) {
                questions = try parseQuestions(from: questionsData)
            }
            
            return Lesson(
                id: metadata["id"] ?? "",
                title: metadata["title"] ?? "",
                description: metadata["description"] ?? "",
                sections: sections,
                questions: questions
            )
        }
        
        private func parseMetadata(in content: String) -> [String: String]? {
            guard let metadataStartRange = content.range(of: metadataStartDelimiter),
                  let metadataEndRange = content.range(of: metadataEndDelimiter, range: metadataStartRange.upperBound..<content.endIndex) else {
                return nil
            }
            
            let metadataContent = String(content[metadataStartRange.lowerBound...metadataEndRange.upperBound])
            guard let metadataData = metadataContent.data(using: .utf8),
                  let metadataDict = try? JSONSerialization.jsonObject(with: metadataData, options: []) as? [String: String] else {
                return nil
            }
            return metadataDict
        }
        
        private func parseSections(in content: String) -> [Section] {
            let sectionRegex = #"=== Section: (.*?) ===\n(.*?)=== EndSection: \1 ==="#
            let regex = try? NSRegularExpression(pattern: sectionRegex, options: .dotMatchesLineSeparators)
            let nsContent = content as NSString
            var sections: [Section] = []
            
            regex?.enumerateMatches(in: content, options: [], range: NSRange(location: 0, length: nsContent.length)) { match, _, _ in
                if let match = match,
                   let titleRange = Range(match.range(at: 1), in: content),
                   let contentRange = Range(match.range(at: 2), in: content) {
                    
                    let title = String(content[titleRange])
                    let sectionContent = String(content[contentRange]).trimmingCharacters(in: .whitespacesAndNewlines)
                    sections.append(Section(title: title, content: sectionContent))
                }
            }
            return sections
        }
        
        private func extractQuestionsData(from content: String) -> String? {
            let questionsStartDelimiter = "["
            let questionsEndDelimiter = "]"
            guard let startRange = content.range(of: questionsStartDelimiter),
                  let endRange = content.range(of: questionsEndDelimiter, range: startRange.upperBound..<content.endIndex) else {
                return nil
            }
            
            return String(content[startRange.lowerBound...endRange.upperBound])
        }
        
        private func parseQuestions(from questionsData: String) throws -> [Question] {
            guard let data = questionsData.data(using: .utf8) else {
                return []
            }
            return try JSONDecoder().decode([Question].self, from: data)
        }
    }
}
