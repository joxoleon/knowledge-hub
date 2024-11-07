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
    @Binding var isPresented: Bool  // Binding property to control visibility

    @State private var selectedTabIndex: Int = 0

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ThemeConstants.verticalGradientDarker
                .ignoresSafeArea()

            // TabView for lesson content
            TabView(selection: $selectedTabIndex) {
                ForEach(viewModel.sections.indices, id: \.self) { index in
                    MarkdownPresentationView(markdownString: viewModel.sections[index].content)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .padding(.top, 30)
            .onChange(of: selectedTabIndex) { oldTabIndex, newTabIndex in
                print("Current tab index: \(newTabIndex)")
            }

            // Close button
            Button(action: {
                isPresented = false // Dismiss the view
            }) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 30))
                    .foregroundColor(.titleGold)
                    .padding(.top, 10)
                    .padding(.trailing, 10)
            }
        }
    }
}


// SwiftUI Preview
struct LessonOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        let testingContentProvider = TestingKHDomainContentProvider()
        let sampleLesson = testingContentProvider.activeTopModule.preOrderLessons.first!
        let viewModel = LessonViewModel(lesson: sampleLesson)
        ReadLessonView(viewModel: viewModel, isPresented: .constant(true))
    }
}
