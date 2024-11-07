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
    static let starButtonSize: CGFloat = 24
}

struct LearningContentMetadataView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Title and Description
            VStack(spacing: 30) {
                Text(viewModel.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.titleColor)
                    .multilineTextAlignment(.center)
                
                Text(viewModel.description)
                    .font(.body)
                    .foregroundColor(.textColor)
                    .padding(.horizontal, 12)
            }
            .padding(.top, 40)
            
            // 1x3 Grid of Metadata Squares
            HStack(spacing: Constants.squarePadding) {
                ForEach(viewModel.metadataItems, id: \.title) { item in
                    MetadataSquareView(
                        iconName: item.iconName,
                        title: item.title,
                        value: item.value,
                        valueColor: item.valueColor
                    )
                    .frame(width: 100, height: 100) // Fixed size for squares
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .padding()
        .background(
            ZStack {
                
                // Star Icon in Top Right Corner
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.toggleStar()
                        }) {
                            Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                                .font(.system(size: Constants.starButtonSize))
                                .foregroundColor(.titleGold)
                                .shadow(color: viewModel.isStarred ? Color.yellow.opacity(0.6) : Color.clear, radius: 4, x: 0, y: 0)
                        }
                        .padding([.top, .trailing], 12)
                    }
                    Spacer()
                }
            }
        )
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
            
            VStack {
                LearningContentMetadataView(viewModel: LearningContentMetadataViewModel(content: Testing.testLesson))
                    .padding()
                
                Spacer()
            }

        }
    }
}
