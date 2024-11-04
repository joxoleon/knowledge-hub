//
//  LessonOverviewView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import SwiftUI
import KHBusinessLogic

struct ReadLessonView: View {
    @ObservedObject var viewModel: LessonViewModel
    @State private var selectedTabIndex: Int = 0

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            ForEach(viewModel.sections.indices, id: \.self) { index in
                LessonSectionView(section: viewModel.sections[index], viewModel: viewModel)
                    .environmentObject(viewModel.colorManager)
                    .tag(index) // Tag each view with its index
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .background(viewModel.colorManager.theme.backgroundColor)
        .onChange(of: selectedTabIndex) {
            print("Current tab index: \($0)") // Print the current tab index
        }
    }
}

// SwiftUI Preview
struct LessonOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        let testingContentProvider = TestingKHDomainContentProvider()
        let sampleLesson = testingContentProvider.activeTopModule.preOrderLessons.first!
        let colorManager = ColorManager(colorTheme: .midnightBlue)
        let viewModel = LessonViewModel(lesson: sampleLesson, colorManager: colorManager)
        ReadLessonView(viewModel: viewModel)
            .environmentObject(ColorManager(colorTheme: .midnightBlue))
    }
}
