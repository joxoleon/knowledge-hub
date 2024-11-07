//
//  LearningContentMetadataView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

fileprivate enum Constants {
    static let backgroundGradient = LinearGradient(colors: [.darkBlue, .deepPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let squareBackgroundGradient = LinearGradient(colors: [.deeperPurple.opacity(0.6), .deepPurple.opacity(0.8)], startPoint: .top, endPoint: .bottom)
    static let squareCornerRadius: CGFloat = 12
    static let squarePadding: CGFloat = 8
}

struct LearningContentMetadataView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Title and Description
            Text(viewModel.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(viewModel.titleColor)
                .padding(.bottom, 4)
            
            Text(viewModel.description)
                .font(.body)
                .foregroundColor(.textColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
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
                            title: viewModel.isStarred ? "Unstar" : "Star",
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
                .fill(Color.deeperPurple.opacity(0.8))
            
            VStack(spacing: 4) {
                if let onToggleFavorite = onToggleFavorite {
                    Button(action: onToggleFavorite) {
                        Image(systemName: iconName)
                            .foregroundColor(iconColor)
                            .font(.system(size: 22))
                    }
                } else {
                    Image(systemName: iconName)
                        .font(.system(size: 22))
                        .foregroundColor(iconColor)
                }
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(titleColor)
                    .multilineTextAlignment(.center)
                
                if let value = value {
                    Text(value)
                        .font(.footnote)
                        .foregroundColor(valueColor)
                        .fontWeight(.bold)
                }
            }
            .padding(8)
        }
    }
}

// Preview for `LearningContentMetadataView`
struct LearningContentMetadataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .ignoresSafeArea()
            
            LearningContentMetadataView(viewModel: LearningContentMetadataViewModel(content: Testing.testLesson))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
