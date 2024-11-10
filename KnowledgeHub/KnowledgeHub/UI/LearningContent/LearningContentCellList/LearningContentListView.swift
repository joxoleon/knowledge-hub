// LearningContentsListView.swift
// KnowledgeHub
//
// Created by Jovan Radivojsa on 10.11.24.
//

import SwiftUI
import Combine
import KHBusinessLogic

enum FilterType {
    case lessons
    case modules
}

struct LearningContentsListView: View {
    @ObservedObject var viewModel: LearningContentsListViewModel

    var body: some View {
        VStack(spacing: 16) {
            // Filter Buttons
            if viewModel.showFilterButtons {
                
                HStack(spacing: 16) {
                    FilterButtonView(
                        icon: IconConstants.lesson,
                        label: "Lessons",
                        isSelected: viewModel.showLessons,
                        action: {
                            viewModel.toggleFilter(for: .lessons)
                        }
                    )
                    
                    FilterButtonView(
                        icon: IconConstants.learningModule,
                        label: "Modules",
                        isSelected: viewModel.showModules,
                        action: {
                            viewModel.toggleFilter(for: .modules)
                        }
                    )
                }
                .padding(.horizontal)
                
                SeparatorView()
            }

            // Learning Content Cells
            if viewModel.cellViewModels.isEmpty {
                Text("No results")
                    .frame(maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.titleGold)
                    .font(.title2)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 3) {
                        ForEach(viewModel.cellViewModels, id: \.id) { cellViewModel in
                            LearningContentCellView(viewModel: cellViewModel)
                                .cornerRadius(8)
                                .onTapGesture {
                                    viewModel.navigateToLearningContent(content: cellViewModel.content)
                                }
                        }
                    }
                }
            }
        }
    }
}

struct FilterButtonView: View {
    let icon: String
    let label: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .titleGold : .placeholderGray)
                    .font(.title2)
                    .padding(.vertical, 6)
                    .padding(.leading, 6)

                Text(label)
                    .foregroundColor(isSelected ? .titleGold : .placeholderGray)
                    .padding(.trailing, 8)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(ThemeConstants.cellGradient))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.titleGold.opacity(isSelected ? 0.5 : 0.2), lineWidth: 1))
        }
    }
}

class LearningContentsListViewModel: ObservableObject {

    // MARK: - Properties
    
    @Published var cellViewModels: [LearningContentMetadataViewModel] = []
    @Published var showLessons: Bool = true {
        didSet {
            filterContent()
        }
    }
    @Published var showModules: Bool = true {
        didSet {
            filterContent()
        }
    }
    let showFilterButtons: Bool = true


    // MARK: - Private Properties
    
    private var allContent: [LearningContent]
    private let mainTabViewModel: MainTabViewModel?

    // MARK: - Initialization
    
    init(content: [LearningContent], mainTabViewModel: MainTabViewModel? = nil, showFilterButtons: Bool) {
        self.allContent = content
        self.mainTabViewModel = mainTabViewModel
        filterContent()
    }

    // MARK: - Content Filtering
    
    private func filterContent() {
        var filteredContent = allContent

        if !showLessons {
            filteredContent = filteredContent.filter { !($0 is Lesson) }
        }
        if !showModules {
            filteredContent = filteredContent.filter { !($0 is LearningModule) }
        }

        cellViewModels = filteredContent.map { LearningContentMetadataViewModel(content: $0) }
    }

    func toggleFilter(for filterType: FilterType) {
        switch filterType {
        case .lessons:
            if showLessons {
                showLessons = false
                if !showModules { showModules = true }
            } else {
                showLessons = true
            }
        case .modules:
            if showModules {
                showModules = false
                if !showLessons { showLessons = true }
            } else {
                showModules = true
            }
        }
    }

    func navigateToLearningContent(content: any LearningContent) {
        print("Navigating to content: \(content.title)")
        if let lesson = content as? Lesson {
            let lessonDetailViewModel = LessonDetailsViewModel(lesson: lesson, mainTabViewModel: mainTabViewModel)
            mainTabViewModel?.navigateTo(.lessonDetail(lessonDetailViewModel))
        } else if let module = content as? LearningModule {
            let moduleDetailViewModel = LearningModuleDetailsViewModel(module: module, mainTabViewModel: mainTabViewModel)
            mainTabViewModel?.navigateTo(.moduleDetail(moduleDetailViewModel))
        }
    }
}

// MARK: - Preview
struct LearningContentsListView_Previews: PreviewProvider {
    static var previews: some View {
        LearningContentsListView(
            viewModel: LearningContentsListViewModel(
                content: Testing.contentProvider.activeTopModule.preOrderLessons + Testing.contentProvider.activeTopModule.levelOrderModules,
                mainTabViewModel: nil,
                showFilterButtons: true
            )
        )
    }
}
