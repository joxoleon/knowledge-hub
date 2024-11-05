//
//  DomainModelExtensions.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import Foundation
import KHBusinessLogic
import SwiftUI

public extension Color {
    static let deepPurple = Color(#colorLiteral(red: 0.23, green: 0.05, blue: 0.27, alpha: 1))
    static let darkBlue = Color(#colorLiteral(red: 0.0, green: 0.15, blue: 0.27, alpha: 1))
    static let lightGreen = Color(#colorLiteral(red: 0.6, green: 0.97, blue: 0.6, alpha: 1))
    static let lightYellow = Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.5, alpha: 1))
    static let lightRed = Color(#colorLiteral(red: 0.97, green: 0.3, blue: 0.3, alpha: 1))
    static let placeholderGray = Color(#colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5))

    static let titleGold = Color(#colorLiteral(red: 0.8470588235, green: 0.6663265001, blue: 0.4084971358, alpha: 1))
    static let titlePurple = Color(#colorLiteral(red: 0.778753221, green: 0.6718989611, blue: 0.9547532201, alpha: 1))
}

public extension CompletionStatus {
    var uiDescription: String {
        switch self {
        case .completed:
            return "Done!"
        case .inProgress:
            return "In progress..."
        case .notStarted:
            return "Not started"
        }
    }

    var icon: String {
        switch self {
        case .completed:
            return "checkmark.circle.fill"
        case .inProgress:
            return "hourglass"
        case .notStarted:
            return "circle"
        }
    }
}

extension Lesson {
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
