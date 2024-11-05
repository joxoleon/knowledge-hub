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
    static let squareBorderColor = Color.titleGold.opacity(0.7)
    static let squareCornerRadius: CGFloat = 15
    static let squarePadding: CGFloat = 8 // Reduced padding for tighter spacing
}

// Main Metadata View
struct LearningContentMetadataView: View {
    @ObservedObject var viewModel: LearningContentViewModelBase
    
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
                            value: viewModel.estimatedReadTimeString,
                            color: .titleGold
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(
                            iconName: viewModel.isStarred ? "star.fill" : "star",
                            title: viewModel.isStarred ? "Press to unstar Content" :"Press to star Content",
                            color: viewModel.isStarred ? .titleGold : .placeholderGray,
                            onToggleFavorite: viewModel.toggleStar
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(
                            iconName: "gauge",
                            title: "Progress",
                            value: viewModel.progressPercentageString,
                            color: viewModel.progressColor
                        )
                        .frame(width: squareSize, height: squareSize)
                    }
                    HStack(spacing: Constants.squarePadding) {
                        MetadataSquareView(
                            iconName: "chart.bar.fill",
                            title: "Score",
                            value: viewModel.scoreString,
                            color: viewModel.scoreColor
                        )
                        .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(iconName: "calendar", title: "Completion", value: "75%", color: .titleGold) // Example for another metric
                            .frame(width: squareSize, height: squareSize)
                        MetadataSquareView(iconName: "bolt.circle", title: "Energy", value: "120kJ", color: .titleGold) // Example for another metric
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
    let title: String
    var value: String? = nil
    var color: Color = .white
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
                            .foregroundColor(color)
                            .font(.system(size: 20)) // Smaller icon size
                    }
                } else {
                    Image(systemName: iconName)
                        .font(.system(size: 24)) // Smaller icon size
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .multilineTextAlignment(.center)
                
                if let value = value {
                    Text(value)
                        .font(.footnote) // Smaller text for values
                        .foregroundColor(color)
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
            
            LearningContentMetadataView(viewModel: LearningContentViewModelBase(content: Testing.testModule))
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}




