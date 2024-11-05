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
    @ObservedObject var viewModel: LearningContentCellViewModel
    @EnvironmentObject var colorManager: ColorManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(viewModel.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(viewModel.titleColor)
                .padding(.vertical, 8)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    // Estimated Read Time
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                        Text(viewModel.estimatedReadTimeString)
                    }
                    .foregroundColor(colorManager.theme.heading2TextColor)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                    // Score and Progress
                    HStack(spacing: 30) {
                        HStack(spacing: 8) {
                            Image(systemName: "gauge")
                            Text(viewModel.progressPercentageString)
                        }
                        .foregroundColor(viewModel.progressColor)

                        HStack(spacing: 8) {
                            Image(systemName: "medal.fill")
                            Text(viewModel.scoreString)
                        }
                        .foregroundColor(viewModel.scoreColor)
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
                
                Spacer()
                
                // Star button
                Button(action: {
                    viewModel.toggleStar()
                }) {
                    Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                        .foregroundColor(viewModel.isStarred ? colorManager.theme.heading1TextColor : .gray)
                        .font(.system(size: Constants.starSize))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding([.vertical], 10)
        .padding([.horizontal], 20)
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
            LearningContentCellView(viewModel: LearningContentCellViewModel(content: Testing.testLesson))
                .environmentObject(colorManager)
            LearningContentCellView(viewModel: LearningContentCellViewModel(content: Testing.testModule))
                .environmentObject(colorManager)
        }
    }
}
