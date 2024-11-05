//
//  LessonCellView.swift
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

struct LessonCellView: View {
    let lesson: Lesson
    @EnvironmentObject var colorManager: ColorManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(lesson.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(colorManager.theme.heading1TextColor)
                .padding(.vertical, 8)
            
            HStack {
                
                VStack(alignment: .leading, spacing: 6) {
                    // Read Time
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .foregroundColor(colorManager.theme.heading2TextColor)
                        
                        Text("\(lesson.estimatedReadTimeSeconds / 60, specifier: "%.0f") min")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorManager.theme.heading2TextColor)
                    }
                    
                    HStack(spacing: 8) {
                        // Score Icon (without score text when nil)
                        lesson.icon
                        
                        Text("\(lesson.score ?? 0.0, specifier: "%.2f")%")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(lesson.scoreColor)

                }
                
                Spacer()
                
                Button(action: {
                    lesson.toggleStar()
                }) {
                    Image(systemName: lesson.isStarred ? "star.fill" : "star")
                        .foregroundColor(lesson.isStarred ? colorManager.theme.heading1TextColor : .gray)
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
        
        LessonCellView(lesson: Testing.testLesson)
            .environmentObject(colorManager)
    }
}
