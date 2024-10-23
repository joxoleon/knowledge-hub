//
//  LessonOverviewView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import SwiftUI

struct LessonOverviewView: View {
    @ObservedObject var viewModel: LessonViewModel

    var body: some View {
        TabView {
            ForEach(viewModel.sections) { section in
                LessonSectionView(section: section)
                    .environmentObject(viewModel.colorManager)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

// SwiftUI Preview
struct LessonOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleLesson = Lesson(
            title: "Sample Lesson",
            sections: [
                LessonSection(content: "# Introduction\n\nThis is the intro section."),
                LessonSection(content: "## Details\n\nHere are the lesson details."),
                LessonSection(content: "### Conclusion\n\nKey takeaways.")
            ]
        )
        let colorManager = ColorManager(colorTheme: .midnightBlue)
        let viewModel = LessonViewModel(lesson: sampleLesson, colorManager: colorManager)
        LessonOverviewView(viewModel: viewModel)
            .environmentObject(ColorManager(colorTheme: .midnightBlue))
    }
}
