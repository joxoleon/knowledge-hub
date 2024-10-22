//
//  ThemeManager.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI

enum ThemeType {
    case midnightBlue
    case graphiteBlack
}

class ThemeManager: ObservableObject {
    
    @Published var currentTheme: ThemeType

    // MARK: - Lesson Theme Configuration
    
    struct LessonTheme {
        // Fonts
        var bodyFont: Font
        var strongFont: Font
        var emphasisFont: Font
        var heading1Font: Font
        var heading2Font: Font
        var heading3Font: Font
        var codeFont: Font
        
        // Text Colors
        var textColor: Color
        var strongTextColor: Color
        var emphasisTextColor: Color
        var quoteTextColor: Color
        var heading1TextColor: Color
        var heading2TextColor: Color
        var heading3TextColor: Color

        // Background Colors
        var backgroundColor: Color
        var blockquoteBackgroundColor: Color
        var blockquoteBorderColor: Color
        var blockCodeBackgroundColor: Color
    }
    
    // Midnight Blue Theme Lesson Settings
    static let midnightBlueTheme = LessonTheme(
        // Fonts
        bodyFont: .system(size: 16, weight: .regular, design: .default),
        strongFont: .system(size: 16, weight: .bold, design: .default),
        emphasisFont: .system(size: 16, weight: .semibold, design: .default),
        heading1Font: .system(size: 24, weight: .bold, design: .default),
        heading2Font: .system(size: 20, weight: .bold, design: .default),
        heading3Font: .system(size: 18, weight: .bold, design: .default),
        codeFont: .system(.body, design: .monospaced),
        
        // Text Colors
        textColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        strongTextColor: Color(#colorLiteral(red: 0.8940594792, green: 0.8049266934, blue: 0.5392691493, alpha: 1)),
        emphasisTextColor: Color(#colorLiteral(red: 0.8940594792, green: 0.8049266934, blue: 0.5392691493, alpha: 1)),
        quoteTextColor: Color(#colorLiteral(red: 0.8062624335, green: 0.8814529777, blue: 0.8070074916, alpha: 1)),
        heading1TextColor: Color(#colorLiteral(red: 0.9021071196, green: 0.760268271, blue: 0.4938241839, alpha: 1)),
        heading2TextColor: Color(#colorLiteral(red: 0.9021071196, green: 0.760268271, blue: 0.4938241839, alpha: 1)),
        heading3TextColor: Color(#colorLiteral(red: 0.9021071196, green: 0.760268271, blue: 0.4938241839, alpha: 1)),

        // Background Colors
        backgroundColor: Color(#colorLiteral(red: 0.098, green: 0.145, blue: 0.203, alpha: 1)),
        blockquoteBackgroundColor: Color(#colorLiteral(red: 0.145, green: 0.192, blue: 0.247, alpha: 1)),
        blockquoteBorderColor: Color(#colorLiteral(red: 0.298, green: 0.537, blue: 0.882, alpha: 1)),
        blockCodeBackgroundColor: Color(#colorLiteral(red: 0.145, green: 0.192, blue: 0.247, alpha: 1))
    )
    
    // Graphite Black Theme Lesson Settings
    static let graphiteBlackTheme = LessonTheme(
        // Fonts
        bodyFont: .system(size: 16, weight: .regular, design: .default),
        strongFont: .system(size: 16, weight: .bold, design: .default),
        emphasisFont: .system(size: 16, weight: .semibold, design: .default),
        heading1Font: .system(size: 24, weight: .bold, design: .default),
        heading2Font: .system(size: 20, weight: .bold, design: .default),
        heading3Font: .system(size: 18, weight: .bold, design: .default),
        codeFont: .system(.body, design: .monospaced),
        
        // Text Colors
        textColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        strongTextColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        emphasisTextColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        quoteTextColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        heading1TextColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        heading2TextColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        heading3TextColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),

        // Background Colors
        backgroundColor: Color(#colorLiteral(red: 0.121, green: 0.121, blue: 0.121, alpha: 1)),
        blockquoteBackgroundColor: Color(#colorLiteral(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)),
        blockquoteBorderColor: Color(#colorLiteral(red: 0.576, green: 0.576, blue: 0.576, alpha: 1)),
        blockCodeBackgroundColor: Color(#colorLiteral(red: 0.161, green: 0.161, blue: 0.161, alpha: 1))
    )
    
    // Current Theme's Lesson Settings
    var lessonTheme: LessonTheme {
        switch currentTheme {
        case .midnightBlue:
            return ThemeManager.midnightBlueTheme
        case .graphiteBlack:
            return ThemeManager.graphiteBlackTheme
        }
    }
    
    // Init with default theme
    init(defaultTheme: ThemeType = .midnightBlue) {
        self.currentTheme = defaultTheme
    }
    
    // Switch Theme
    func switchTheme(to theme: ThemeType) {
        self.currentTheme = theme
    }
}

