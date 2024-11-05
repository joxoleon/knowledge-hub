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
    static let starSize: CGFloat = 20 // Adjust this value as needed to control the size
}

struct LearningContentCellView: View {
    let learningContent: LearningContent
    @EnvironmentObject var colorManager: ColorManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(learningContent.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(learningContent.titleColor)
                .padding(.vertical, 8)
            
            HStack {
                
                VStack(alignment: .leading, spacing: 8) {
                    // Read Time
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .foregroundColor(colorManager.theme.heading2TextColor)
                        
                        Text("\(learningContent.estimatedReadTimeSeconds / 60, specifier: "%.0f") min")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorManager.theme.heading2TextColor)
                    }
                    
                    HStack(spacing: 8) {
                        // Score Icon (without score text when nil)
                        learningContent.icon
                        
                        Text("\(learningContent.score ?? 0.0, specifier: "%.2f")%")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(learningContent.scoreColor)

                }
                
                Spacer()
                
                Button(action: {
                    learningContent.toggleStar()
                }) {
                    Image(systemName: learningContent.isStarred ? "star.fill" : "star")
                        .foregroundColor(learningContent.isStarred ? colorManager.theme.heading1TextColor : .gray)
                        .font(.system(size: Constants.starSize)) // Doubling the star size
                }
                .buttonStyle(PlainButtonStyle()) // to remove default button appearance
            }
        }
        .padding([.vertical], 10)
        .padding([.horizontal], 20)
        .background(Constants.backgroundGradient)
    }
}

#Preview {
    let colorManager = ColorManager(colorTheme: .midnightBlue)

    ZStack {
        Color.black
            .edgesIgnoringSafeArea(.all)
        VStack(spacing: 2) {
            LearningContentCellView(learningContent: Testing.testLesson)
                .environmentObject(colorManager)
            LearningContentCellView(learningContent: Testing.testModule)
                .environmentObject(colorManager)
        }

    }
}
