//
//  LearningContentMetadataViewModel.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

class LearningContentMetadataViewModel: ObservableObject, Identifiable {
    @Published var title: String = .empty
    @Published var description: String = .empty
    @Published var isStarred: Bool = false
    @Published var metadataItems: [MetadataItem] = []
    
    private var content: LearningContent
    private var cancellables = Set<AnyCancellable>()

    // Computed Properties for Colors
    var id: String { content.id }
    var titleColor: Color { content is Lesson ? .titleGold : .titlePurple }
    
    // Initializer that sets up properties based on `LearningContent`
    init(content: LearningContent) {
        self.content = content
        refreshValues()
    }

    // Toggle star/favorite status
    func toggleStar() {
        content.toggleStar()
        self.isStarred = content.isStarred
    }

    // Refresh displayed values based on the latest data from `LearningContent`
    func refreshValues() {
        title = content.title
        description = content.description
        isStarred = content.isStarred
        metadataItems = [
            MetadataItem(iconName: "clock", title: "Read Time", value: content.estimatedReadTimeSeconds.timeString),
            MetadataItem(iconName: "checkmark.circle", title: "Completion", value: content.completionPercentage.percentageString, valueColor: progressColor),
            MetadataItem(iconName: "rosette", title: "Score", value: content.score?.percentageString ?? "0%", valueColor: scoreColor)
        ]
    }
    
    // Computed Properties for Colors
    var scoreColor: Color {
        guard let score = content.score else { return .placeholderGray }
        return score >= 80.0 ? .lightGreen : score >= 60.0 ? .lightYellow : .lightRed
    }
    
    var progressColor: Color {
        Color.interpolate(from: .placeholderGray, to: .lightGreen, fraction: content.completionPercentage / 100.0)
    }
}

// MARK: - MetadataItem Struct

struct MetadataItem {
    let iconName: String
    let title: String
    let value: String
    var valueColor: Color = .titleGold
}

// MARK: - Extensions

extension Double {
    var timeString: String {
        let totalSeconds = Int(self)
        let days = totalSeconds / 86400
        let hours = (totalSeconds % 86400) / 3600
        let minutes = (totalSeconds % 3600) / 60
        
        var components: [String] = []
        if days > 0 { components.append("\(days) day\(days > 1 ? "s" : "")") }
        if hours > 0 { components.append("\(hours) h") }
        if minutes > 0 || components.isEmpty { components.append("\(minutes) min") }
        
        return components.joined(separator: " ")
    }
    
    var percentageString: String {
        "\(Int(self))%"
    }
}

extension String {
    static let empty = ""
}

extension Color {
    static func interpolate(from color1: Color, to color2: Color, fraction: CGFloat) -> Color {
        let uiColor1 = UIColor(color1)
        let uiColor2 = UIColor(color2)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r = r1 + (r2 - r1) * fraction
        let g = g1 + (g2 - g1) * fraction
        let b = b1 + (b2 - b1) * fraction
        let a = a1 + (a2 - a1) * fraction
        
        return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
}
