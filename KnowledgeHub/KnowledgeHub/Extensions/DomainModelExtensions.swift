//
//  DomainModelExtensions.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import Foundation
import KHBusinessLogic
import SwiftUI

public enum ThemeConstants {
    static let verticalGradient = LinearGradient(colors: [.black, .deepPurple2], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let verticalGradientDarker = LinearGradient(colors: [.black, .deepPurple3], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let verticalGradient3 = LinearGradient(colors: [.deepPurple2, .black, .deepPurple2], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let verticalGradient2 = LinearGradient(colors: [.deepPurple2, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let cellGradient = LinearGradient(colors: [.deepPurple2, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let horizontalGradient = LinearGradient(colors: [.darkBlue, .deepPurple], startPoint: .leading, endPoint: .trailing)
}

public enum IconConstants {
    static let readTime = "clock"
    static let completionProgress = "checkmark.circle"
    static let score = "rosette"
    static let lesson = "book.circle.fill"
    static let learningModule = "books.vertical.circle.fill"
    static let searchIcon = "magnifyingglass.circle.fill"
    static let browseIcon = "list.dash.circle.fill"
    static let statsIcon = "chart.bar.xaxis"
    static let improvementIcon = "exclamationmark.triangle.fill"
    static let starAction = "star.circle.fill"
    static let continueAction = "play.circle.fill"
    static let repeatAction = "arrow.counterclockwise.circle.fill"
    static let flashcardsAction = "bolt.circle.fill"
    static let quizAction = "questionmark.circle.fill"
}

public enum LessonSectionTheme {
    static let textColor = Color(#colorLiteral(red: 0.7476351857, green: 0.7833244205, blue: 0.8772838116, alpha: 1))
    static let gold1 = Color(#colorLiteral(red: 0.8470588235, green: 0.6663265001, blue: 0.4084971358, alpha: 1))
    static let gold2 = Color(#colorLiteral(red: 0.8470588235, green: 0.6663265001, blue: 0.4084971358, alpha: 1))
    static let codeBackground = Color.deepPurple3
}

public extension Color {
    static let violet = Color(#colorLiteral(red: 0.2094331086, green: 0.002857988002, blue: 0.421089828, alpha: 1))
    static let deepPurple = Color(#colorLiteral(red: 0.2461335659, green: 0.02346310765, blue: 0.2728917301, alpha: 1))
    static let deepPurple2 = Color(#colorLiteral(red: 0.1855854094, green: 0, blue: 0.2303968966, alpha: 1))
    static let deepPurple3 = Color(#colorLiteral(red: 0.0856006667, green: 0.0002626918431, blue: 0.1521573663, alpha: 1))
    static let deeperPurple = Color(#colorLiteral(red: 0.04155740887, green: 0.001098917914, blue: 0.07130322605, alpha: 1))
    static let deeperPurple2 = Color(#colorLiteral(red: 0.07679689676, green: 0.001972509548, blue: 0.1394259036, alpha: 1))
    static let darkBlue = Color(#colorLiteral(red: 0, green: 0.08854200691, blue: 0.2434067726, alpha: 1))
    static let lightGreen = Color(#colorLiteral(red: 0.6, green: 0.97, blue: 0.6, alpha: 1))
    static let lightYellow = Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.5, alpha: 1))
    static let lightRed = Color(#colorLiteral(red: 0.8631109595, green: 0.3246425986, blue: 0.3595300913, alpha: 1))
    static let placeholderGray = Color(#colorLiteral(red: 0.5489625335, green: 0.5489625335, blue: 0.5489625335, alpha: 0.5999811178))
    static let textColor = Color(#colorLiteral(red: 0.7476351857, green: 0.7833244205, blue: 0.8772838116, alpha: 1))

    static let titleGold = Color(#colorLiteral(red: 0.8470588235, green: 0.6663265001, blue: 0.4084971358, alpha: 1))
    static let titlePurple = Color(#colorLiteral(red: 0.6484809518, green: 0.5859546065, blue: 0.9822049737, alpha: 1))
}

extension LearningContent {
    var titleColor: Color {
        if self is Lesson {
            return .titleGold
        } else {
            return .titlePurple
        }
    }
    
    var scoreColor: Color {
        guard let score else { return .placeholderGray }
        if score >= 80.0 {
            return .lightGreen
        } else if score >= 60.0 {
            return .lightYellow
        } else {
            return .lightRed
        }
    }
    
    var icon: Image {
        return Image(systemName: "medal.fill")
    }
}


extension Array where Element == LearningContent {
    func lessons() -> [Lesson] {
        return self.compactMap { $0 as? Lesson }
    }
    
    func modules() -> [LearningModule] {
        return self.compactMap { $0 as? LearningModule }
    }
}

extension Array where Element == String {
    var uniqueElements: [String] {
        var uniqueElements: [String] = []
        for element in self {
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
        return uniqueElements
    }
}
