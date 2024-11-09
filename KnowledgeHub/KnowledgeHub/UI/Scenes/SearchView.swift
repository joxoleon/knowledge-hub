//  BrowseView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var query: String = ""
    @State private var showLessons: Bool = true
    @State private var showModules: Bool = true
    
    var body: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                // Search Bar with Magnifying Glass Icon
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.titleGold)
                        .font(.title2)
                    
                    ZStack(alignment: .leading) {
                        if query.isEmpty {
                            Text("Search...")
                                .foregroundColor(.titleGold.opacity(0.3)) // Set your desired placeholder color here
                                .padding(8)
                        }
                        
                        TextField("", text: $query, onCommit: {
                            viewModel.performSearch(with: query)
                        })
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.titleGold) // Text color when user types
                        .padding(8)
                    }
                    .background(RoundedRectangle(cornerRadius: 8).fill(ThemeConstants.cellGradient))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.titleGold.opacity(0.8), lineWidth: 1))
                }
                .padding([.horizontal, .top])
                
                // Filter Buttons
                HStack(spacing: 16) {
                    SearchFilterButtonView(
                        icon: IconConstants.lesson,
                        label: "Lessons",
                        isSelected: showLessons,
                        action: {
                            toggleFilter(&showLessons, otherFilter: &showModules)
                        }
                    )
                    
                    SearchFilterButtonView(
                        icon: IconConstants.learningModule,
                        label: "Modules",
                        isSelected: showModules,
                        action: {
                            toggleFilter(&showModules, otherFilter: &showLessons)
                        }
                    )
                }
                .padding(.horizontal)
                
                // Contents List with NavigationLink
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(viewModel.cellViewModels, id: \.id) { cellViewModel in
                        LearningContentCellView(viewModel: cellViewModel)
                            .cornerRadius(8)
                            .onTapGesture {
                                viewModel.navigateToLearningContent(content: cellViewModel.content)
                            }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.loadDefaultContent()
        }
        .onChange(of: query) { _, newQuery in
            if newQuery.isEmpty {
                viewModel.loadDefaultContent()
            } else {
                viewModel.performSearch(with: newQuery)
            }
        }
    }
    
    // Ensures at least one filter is always active
    private func toggleFilter(_ filter: inout Bool, otherFilter: inout Bool) {
        if filter {
            filter.toggle()
            if !otherFilter {
                otherFilter.toggle()
            }
        } else {
            filter.toggle()
        }
    }
}

struct SearchFilterButtonView: View {
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

fileprivate enum SearchConstants {
    static let relevanceThreshold = 0.2
}

class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var cellViewModels: [LearningContentMetadataViewModel] = []
    
    private let contentProvider: any KHDomainContentProviderProtocol
    private let mainTabViewModel: MainTabViewModel?
    
    private lazy var defaultContents: [LearningContent] = {
        contentProvider.activeTopModule.levelOrderModules + contentProvider.activeTopModule.preOrderLessons
    }()
    
    // MARK: - Initialization
    init(contentProvider: any KHDomainContentProviderProtocol) {
        self.contentProvider = contentProvider
        loadDefaultContent()
    }
    
    // MARK: - Default Content Loading
    func loadDefaultContent() {
        searchResultsLessons = defaultLessons
        searchResultsModules = defaultModules
    }
    
    // MARK: - Computed Properties
    private var defaultLessons: [Lesson] {
        contentProvider.activeTopModule.preOrderLessons
    }
    
    private var defaultModules: [LearningModule] {
        contentProvider.activeTopModule.levelOrderModules
    }
    
    // MARK: - Search Functionality
    func performSearch(with query: String) {
        let searchResults = contentProvider.searchContent(with: query, relevanceThreshold: SearchConstants.relevanceThreshold)
        self.searchResultsLessons = searchResults.toLessons()
        self.searchResultsModules = searchResults.toModules()
    }
    
    func navigateToLearningContent(content: any LearningContent) {
        if let lesson = content as? Lesson {
            let lessonDetailViewModel = LessonDetailsViewModel(lesson: lesson, mainTabViewModel: self.mainTabViewModel)
            mainTabViewModel?.navigateTo(.lessonDetail(lessonDetailViewModel))
        } else if let module = content as? LearningModule {
            let learningModuleDetailViewModel = LearningModuleDetailsViewModel(module: module, mainTabViewModel: self.mainTabViewModel)
            mainTabViewModel?.navigateTo(.moduleDetail(learningModuleDetailViewModel))
        }
    }
}

// MARK: - Array Extension
public extension Array where Element == LearningContent {
    func toLessons() -> [Lesson] {
        self.compactMap { $0 as? Lesson }
    }
    
    func toModules() -> [LearningModule] {
        self.compactMap { $0 as? LearningModule }
    }
}

// MARK: - Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(contentProvider: Testing.contentProvider))
    }
}
