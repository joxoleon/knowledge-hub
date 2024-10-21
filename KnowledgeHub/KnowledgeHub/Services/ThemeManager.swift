//
//  ThemeManager.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var backgroundColor: Color = .background_1
    @Published var textColor: Color = .text_color_1
    @Published var headingColor: Color = .text_color_3
    @Published var secondaryTextColor: Color = .text_color_3
    @Published var boldTextColor: Color = .text_color_3
    
    private init() {}
    
    func setTheme(background: Color, text: Color) {
        self.backgroundColor = background
        self.textColor = text
    }
}

extension Color {
    static let background_1 = Color("background-1")
    static let background_2 = Color("background-2")
    static let background_3 = Color("background-3")
    
    static let text_color_1 = Color("text-1")
    static let text_color_2 = Color("text-2")
    static let text_color_3 = Color("text-3")
}
