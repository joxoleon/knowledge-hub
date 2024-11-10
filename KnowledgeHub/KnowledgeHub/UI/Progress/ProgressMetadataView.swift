//
//  ProgressMetadataView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 10.11.24..
//

import SwiftUI
import KHBusinessLogic
import Combine

fileprivate enum ProgressConstants {
    static let backgroundGradient = LinearGradient(colors: [.darkBlue, .deepPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let squareBackgroundGradient = LinearGradient(colors: [.deeperPurple.opacity(0.6), .deepPurple.opacity(0.8)], startPoint: .top, endPoint: .bottom)
    static let squareCornerRadius: CGFloat = 12
    static let squarePadding: CGFloat = 10
    static let squareSize: CGFloat = 120
    static let starButtonSize: CGFloat = 24
}

struct ProgressMetadataView: View {
    @ObservedObject var viewModel: ProgressMetadataViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                
                // Title
                Text("\(viewModel.title) Progress Overview")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.titleGold)
                    .padding()
                    .multilineTextAlignment(.center)
                
                // Grid of metadata squares
                // 3x2 Grid of metadata squares
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: ProgressConstants.squarePadding), count: 3), spacing: ProgressConstants.squarePadding) {
                    ForEach(viewModel.metadataItems.prefix(6), id: \.title) { item in
                        MetadataSquareView(
                            iconName: item.iconName,
                            title: item.title,
                            value: item.value,
                            valueColor: item.valueColor
                        )
                        .frame(width: ProgressConstants.squareSize, height: ProgressConstants.squareSize)
                    }
                }
            }
        }
    }
}

// MARK: - ViewModel for ProgressMetadataView

class ProgressMetadataViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var metadataItems: [MetadataItem] = []
    
    private var topLevelModule: LearningModule
    
    init(contentProvider: any KHDomainContentProviderProtocol) {
        self.topLevelModule = contentProvider.activeTopModule
        setupMetadata()
    }
    
    func setupMetadata() {
        title = topLevelModule.title
        
        // Calculate metadata
        let preOrderLessons = topLevelModule.preOrderLessons
        let finishedLessons = preOrderLessons.filter { $0.isComplete }
        let completedReadTime = preOrderLessons.filter { $0.isComplete }.reduce(0) { $0 + $1.estimatedReadTimeSeconds }.timeString
        let totalReadTime = topLevelModule.estimatedReadTimeSeconds.timeString
        let finishedLessonCount = finishedLessons.count
        let totalLessonCount = preOrderLessons.count
        let finishedQuestions = topLevelModule.questions.filter { $0.isComplete }.count
        let totalQuestions = topLevelModule.questions.count
        let lessonsToImprove = finishedLessons.filter { $0.score ?? 0.0 < 100.0 }.count
        
        // Calculate colors
        let lessonsToImproveColor = lessonsToImprove > 0 ? Color.lightRed : Color.lightGreen
        
        metadataItems = [
            MetadataItem(
                iconName: IconConstants.readTime,
                title: "Total Read Time",
                value: " \(completedReadTime) / \(totalReadTime)"
            ),
            MetadataItem(
                iconName: "book.fill",
                title: "Lessons Finished",
                value: "\(finishedLessonCount) / \(totalLessonCount)"
            ),
            MetadataItem(
                iconName: "questionmark.circle.fill",
                title: "Questions Finished",
                value: "\(finishedQuestions) / \(totalQuestions)"
            ),
            MetadataItem(
                iconName: IconConstants.improvementIcon,
                title: "Lessons To Improve",
                value: "\(lessonsToImprove)",
                valueColor: lessonsToImproveColor
            ),
            MetadataItem(
                iconName: IconConstants.completionProgress,
                title: "Completion",
                value: topLevelModule.completionPercentage.percentageString,
                valueColor: progressColor
            ),
            MetadataItem(
                iconName: IconConstants.score,
                title: "Score",
                value: topLevelModule.score?.percentageString ?? "0%",
                valueColor: scoreColor
            ),
        ]
    }
    
    // Computed properties for colors
    var progressColor: Color {
        Color.interpolate(from: .placeholderGray, to: .lightGreen, fraction: topLevelModule.completionPercentage / 100.0)
    }
    
    var scoreColor: Color {
        guard let score = topLevelModule.score else { return .placeholderGray }
        return score >= 80.0 ? .lightGreen : score >= 60.0 ? .lightYellow : .lightRed
    }
}


// MARK: - Preview

struct ProgressMetadataView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProgressMetadataViewModel(contentProvider: Testing.contentProvider)
        
        ZStack {
            ThemeConstants.verticalGradient
                .ignoresSafeArea()
            VStack {
                ProgressMetadataView(viewModel: viewModel)
                
                Spacer()
            }
        }
    }
}
