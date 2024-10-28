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
        case metadataParsingFailed
        case invalidSection
        case questionsParsingFailed
    }
    
    class LessonParser {
        
        // MARK: - Deserialization structs
        
        fileprivate struct LessonMetadata: Codable {
            var id: String
            var title: String
            var description: String
        }
        
        // MARK: - Delimiters
        private let metadataStartDelimiter = "{| metadata |}"
        private let metadataEndDelimiter = "{| endmetadata |}"
        private let questionsStartDelimiter = "{| questions |}"
        private let questionsEndDelimiter = "{| endquestions |}"
        private let sectionRegexPattern = #"=== Section: (.*?) ===\n(.*?)=== EndSection: \1 ==="#
        
        // MARK: - Parse Lesson
        func parseLesson(from fileURL: URL) throws -> Lesson {
            let content = try String(contentsOf: fileURL)
            let metadata = try parseMetadata(in: content)
            let sections = parseSections(in: content)
            let questions = try parseQuestions(from: content)
            
            return Lesson(
                id: metadata.id,
                title: metadata.title,
                description: metadata.description,
                sections: sections,
                questions: questions
            )
        }
        
        // MARK: - Metadata Parsing
        private func parseMetadata(in content: String) throws -> LessonMetadata  {
            guard let metadataContent = extractContent(from: content, startDelimiter: metadataStartDelimiter, endDelimiter: metadataEndDelimiter) else {
                throw ParsingError.metadataParsingFailed
            }
            
            guard let data = metadataContent.data(using: .utf8) else {
                throw ParsingError.metadataParsingFailed
            }
            
            return try JSONDecoder().decode(LessonMetadata.self, from: data)
        }
        
        // MARK: - Section Parsing
        private func parseSections(in content: String) -> [Section] {
            let regex = try? NSRegularExpression(pattern: sectionRegexPattern, options: .dotMatchesLineSeparators)
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
        
        // MARK: - Questions Parsing
        private func parseQuestions(from content: String) throws -> [Question] {
            guard let questionsData = extractContent(from: content, startDelimiter: questionsStartDelimiter, endDelimiter: questionsEndDelimiter) else {
                throw ParsingError.questionsParsingFailed
            }
            
            guard let data = questionsData.data(using: .utf8) else {
                throw ParsingError.questionsParsingFailed
            }
            
            return try JSONDecoder().decode([Question].self, from: data)
        }
        
        // MARK: - Helper Methods
        private func extractContent(from content: String, startDelimiter: String, endDelimiter: String) -> String? {
            guard let startRange = content.range(of: startDelimiter),
                  let endRange = content.range(of: endDelimiter, range: startRange.upperBound..<content.endIndex) else {
                return nil
            }
            
            return String(content[startRange.upperBound..<endRange.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
