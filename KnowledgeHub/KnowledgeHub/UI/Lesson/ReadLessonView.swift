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
                MarkdownPresentationView(markdownString: viewModel.sections[index].content)
                    .tag(index) // Tag each view with its index
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onChange(of: selectedTabIndex) { oldTabIndex, newTabIndex in
            print("Current tab index: \(newTabIndex)") // Print the current tab index
        }
    }
}

// SwiftUI Preview
struct LessonOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        let testingContentProvider = TestingKHDomainContentProvider()
        let sampleLesson = testingContentProvider.activeTopModule.preOrderLessons.first!
        let viewModel = LessonViewModel(lesson: sampleLesson)
        ReadLessonView(viewModel: viewModel)
    }
}
