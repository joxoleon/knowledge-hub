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
    static let horizontalGradient = LinearGradient(colors: [.darkBlue, .deepPurple], startPoint: .leading, endPoint: .trailing)
}

public extension Color {
    static let deepPurple = Color(#colorLiteral(red: 0.2461335659, green: 0.02346310765, blue: 0.2728917301, alpha: 1))
    static let deepPurple2 = Color(#colorLiteral(red: 0.1855854094, green: 0, blue: 0.2303968966, alpha: 1))
    static let deeperPurple = Color(#colorLiteral(red: 0.09602113813, green: 0.001058581518, blue: 0.1699076891, alpha: 1))
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
