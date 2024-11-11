//
//  LearningContentMetadataView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

fileprivate enum Constants {
    static let squareCornerRadius: CGFloat = 12
    static let squarePadding: CGFloat = 10
    static let squareSize: CGFloat = 100
    static let starButtonSize: CGFloat = 24
}

struct LearningContentMetadataView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 30) {
                
                // Title and Star Button
                HStack {
                    Text(viewModel.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.titleColor)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleStar()
                    }) {
                        Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                            .font(.system(size: Constants.starButtonSize))
                            .foregroundColor(viewModel.isStarred ? .titleGold : .placeholderGray)
                            .shadow(color: viewModel.isStarred ? Color.titleGold.opacity(0.6) : Color.clear, radius: 5, x: 0, y: 0)
                    }
                }
                .padding(.horizontal, 8)

                
                Text(viewModel.description)
                    .font(.body)
                    .foregroundColor(.textColor)
                    .lineLimit(nil)
                
                // Grid of metadata squares
                HStack(spacing: Constants.squarePadding) {
                    ForEach(viewModel.metadataItems, id: \.title) { item in
                        MetadataSquareView(
                            iconName: item.iconName,
                            title: item.title,
                            value: item.value,
                            valueColor: item.valueColor
                        )
                        .frame(width: Constants.squareSize, height: Constants.squareSize)
                    }
                }
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
                .fill(ThemeConstants.verticalGradient2)
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
                    .font(.system(size: 10))
                    .fontWeight(.medium)
                    .foregroundColor(titleColor)
                    .multilineTextAlignment(.center)
                
                if let value = value {
                    Text(value)
                        .font(.system(size: 14))
                        .foregroundColor(valueColor)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(8)
        }
    }
}

struct SeparatorView: View {
    var body: some View {
        Rectangle()
            .fill(Color.titleGold.opacity(0.2))
            .frame(height: 1)
    }
}

// Preview for `LearningContentMetadataView`
struct LearningContentMetadataView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .ignoresSafeArea()
            
            VStack {
                LearningContentMetadataView(viewModel: LearningContentMetadataViewModel(content: Testing.testLesson))
                    .padding()
                
                Spacer()
            }

        }
    }
}
