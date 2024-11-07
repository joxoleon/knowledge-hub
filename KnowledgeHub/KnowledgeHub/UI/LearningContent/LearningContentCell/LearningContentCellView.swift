//
//  LearningContentCellView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI
import KHBusinessLogic

fileprivate enum Constants {
    static let backgroundGradient = LinearGradient(colors: [.darkBlue, .deepPurple], startPoint: .leading, endPoint: .trailing)
    static let starSize: CGFloat = 20
}

struct LearningContentCellView: View {
    @ObservedObject var viewModel: LearningContentMetadataViewModel
    @EnvironmentObject var colorManager: ColorManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(viewModel.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(viewModel.titleColor)
                .padding(.top, 8)
                .padding(.bottom, 15)
            
            HStack(alignment: .center) {
                // Horizontal Layout for Metadata Items
                HStack(spacing: 20) {
                    ForEach(viewModel.metadataItems, id: \.title) { item in
                        HStack(spacing: 4) {
                            Image(systemName: item.iconName)
                            Text(item.value)
                        }
                        .foregroundColor(item.valueColor)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                // Star button
                Button(action: {
                    viewModel.toggleStar()
                }) {
                    Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                        .foregroundColor(.titleGold)
                        .font(.system(size: Constants.starSize))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 18)
        .background(Constants.backgroundGradient)
        .onAppear {
            viewModel.refreshValues()
        }
    }
}

// Preview for the updated LearningContentCellView
#Preview {
    let colorManager = ColorManager(colorTheme: .midnightBlue)

    ZStack {
        Color.black
            .edgesIgnoringSafeArea(.all)
        VStack(spacing: 2) {
            LearningContentCellView(viewModel: LearningContentMetadataViewModel(content: Testing.testLesson))
                .environmentObject(colorManager)
            LearningContentCellView(viewModel: LearningContentMetadataViewModel(content: Testing.testModule))
                .environmentObject(colorManager)
        }
    }
}
