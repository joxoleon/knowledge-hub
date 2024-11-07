//
//  LearningContentCellView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI
import KHBusinessLogic

fileprivate enum Constants {
    static let starSize: CGFloat = 20
}

struct LearningContentCellView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(viewModel.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(viewModel.titleColor)
                .padding(.top, 8)
                .padding(.bottom, 15)
            
            HStack(alignment: .center) {
                // Horizontal Layout for Metadata Items
                HStack(spacing: 20) {
                    ForEach(viewModel.metadataItems, id: \.title) { item in
                        HStack(spacing: 4) {
                            Image(systemName: item.iconName)
                            Text(item.value ?? .empty)
                        }
                        .foregroundColor(item.valueColor)
                        .font(.subheadline)
                        .fontWeight(.regular)
                    }
                }
                
                Spacer()
                
                // Star button
                Button(action: {
                    viewModel.toggleStar()
                }) {
                    Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                        .foregroundColor(viewModel.isStarred ? .titleGold : .placeholderGray)
                        .font(.system(size: Constants.starSize))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 18)
        .background(ThemeConstants.cellGradient)
        .cornerRadius(12)
        // Add a border overlay
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.titleGold.opacity(0.2), lineWidth: 1)
        )
        .onAppear {
            viewModel.refreshValues()
        }
    }
}

// Preview for the updated LearningContentCellView
#Preview {
    ZStack {
        Color.black
            .edgesIgnoringSafeArea(.all)
        VStack(spacing: 3) {
            LearningContentCellView(viewModel: LearningContentMetadataViewModel(content: Testing.testLesson))
            LearningContentCellView(viewModel: LearningContentMetadataViewModel(content: Testing.testModule))
        }
    }
}
