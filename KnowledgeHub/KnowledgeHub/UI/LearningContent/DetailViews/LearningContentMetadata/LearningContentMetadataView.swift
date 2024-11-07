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
    static let squarePadding: CGFloat = 10
    static let starButtonSize: CGFloat = 36
}

struct LearningContentMetadataView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .topTrailing) {
                // Title and Description
                VStack(spacing: 30) {
                    Text(viewModel.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.titleColor)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20
                        )
                    
                    Text(viewModel.description)
                        .font(.body)
                        .foregroundColor(.textColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, 12)
                
                // Floating star button
                Button(action: {
                    viewModel.toggleStar()
                }) {
                    Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundColor(viewModel.isStarred ? .titleGold : .gray)
                        .frame(width: Constants.starButtonSize, height: Constants.starButtonSize)
                        .background(Circle().fill(Color.deepPurple2))
                        .shadow(color: viewModel.isStarred ? Color.yellow.opacity(0.6) : Color.clear, radius: 4, x: 0, y: 0)
                }
            
            }
            
            // 1x3 Grid of Metadata Squares
            GeometryReader { geometry in
                let squareSize = (geometry.size.width - 2 * Constants.squarePadding) / 3
                
                HStack(spacing: Constants.squarePadding) {
                    MetadataSquareView(
                        iconName: "clock",
                        title: "Read Time",
                        value: viewModel.estimatedReadTimeString
                    )
                    .frame(width: squareSize, height: squareSize)
                    
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
                }
                .padding(.vertical, 10)
            }
        }
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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.squareCornerRadius)
                .fill(Color.deeperPurple)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.squareCornerRadius)
                        .strokeBorder(Color.titleGold.opacity(0.2), lineWidth: 1)
                )
            
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(size: 22))
                    .foregroundColor(iconColor)
                
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
