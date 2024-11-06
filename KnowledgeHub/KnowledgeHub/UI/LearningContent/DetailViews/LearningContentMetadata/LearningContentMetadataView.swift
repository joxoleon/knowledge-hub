//
//  LearningContentMetadataView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

// Constants for colors and styles
fileprivate enum Constants {
    static let backgroundGradient = LinearGradient(colors: [.darkBlue, .deepPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let squareBackgroundColor = Color.deeperPurple
    static let squareBorderColor = Color.titleGold.opacity(0.4)
    static let squareCornerRadius: CGFloat = 15
    static let squarePadding: CGFloat = 8 // Reduced padding for tighter spacing
}

// Main Metadata View
struct LearningContentMetadataView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Title and Description
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(viewModel.titleColor)
                .padding(.bottom, 4)
            
            Text(viewModel.description)
                .font(.body)
                .foregroundColor(.textColor)
                .padding(.bottom, 8)
            
            // 3x2 Grid of Metadata Squares
            GeometryReader { geometry in
                let squareSize = (geometry.size.width - 2 * Constants.squarePadding) / 3
                
                VStack(spacing: Constants.squarePadding) {
                    HStack(spacing: Constants.squarePadding) {
                        MetadataSquareView(
                            iconName: "clock",
                            title: "Read Time",
                            value: viewModel.estimatedReadTimeString
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(
                            iconName: "flag.fill",
                            title: "Level",
                            value: viewModel.proficiencyString
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(
                            iconName: "questionmark.circle",
                            title: "Quiz Size",
                            value: viewModel.questionCountString
                        )
                        .frame(width: squareSize, height: squareSize)
                    }
                    HStack(spacing: Constants.squarePadding) {
                        MetadataSquareView(
                            iconName: "checkmark.circle",
                            title: "Completion",
                            value: viewModel.progressPercentageString,
                            valueColor: viewModel.progressColor
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(
                            iconName: "rosette",
                            title: "Score",
                            value: viewModel.scoreString,
                            valueColor: viewModel.scoreColor
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(
                            iconName: viewModel.isStarred ? "star.fill" : "star",
                            iconColor: viewModel.isStarred ? .titleGold : .placeholderGray,
                            title: viewModel.isStarred ? "Press to unstar Content" :"Press to STAR Content",
                            titleColor: viewModel.isStarred ? .titleGold : .placeholderGray,
                            onToggleFavorite: viewModel.toggleStar
                        )
                        .frame(width: squareSize, height: squareSize)

                    }
                }
                .padding(.vertical, 10)
            }
        }
        .padding()
        .background(Constants.backgroundGradient)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

// MARK: - Metadata Square View

struct MetadataSquareView: View {
    let iconName: String
    var iconColor: Color = .titleGold
    let title: String
    var titleColor: Color = .titleGold
    var value: String? = nil
    var valueColor: Color = .titleGold
    var onToggleFavorite: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.squareCornerRadius)
                .fill(Constants.squareBackgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.squareCornerRadius)
                        .stroke(Constants.squareBorderColor, lineWidth: 1)
                )
            
            VStack(spacing: 6) { // Reduced spacing for compactness
                if let onToggleFavorite = onToggleFavorite {
                    Button(action: onToggleFavorite) {
                        Image(systemName: iconName)
                            .foregroundColor(iconColor)
                            .font(.system(size: 20))
                    }
                } else {
                    Image(systemName: iconName)
                        .font(.system(size: 24))
                        .foregroundColor(iconColor)
                }
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(titleColor)
                    .multilineTextAlignment(.center)
                
                if let value = value {
                    Text(value)
                        .font(.footnote)
                        .foregroundColor(valueColor)
                        .fontWeight(.bold)
                }
            }
            .padding(6)
        }
    }
}

// Preview for `LearningContentMetadataView`
struct LearningContentMetadataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            LearningContentMetadataView(viewModel: LearningContentMetadataViewModel(content: Testing.testLesson))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}




