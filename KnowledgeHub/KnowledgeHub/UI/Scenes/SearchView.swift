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
    
    var body: some View {
        VStack(spacing: 16) {
            // Search Bar with Magnifying Glass Icon
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.titleGold)
                    .font(.title2)
                    .padding(.leading,8)
                
                ZStack(alignment: .leading) {
                    if viewModel.query.isEmpty {
                        Text("Search...")
                            .foregroundColor(.titleGold.opacity(0.3))
                            .padding(8)
                    }
                    
                    TextField("", text: $viewModel.query)
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.titleGold)
                        .padding(8)
                }
            }
            .padding(2)
            .background(RoundedRectangle(cornerRadius: 8).fill(ThemeConstants.cellGradient))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.titleGold.opacity(0.8), lineWidth: 1))
            .padding([.horizontal, .top])
            
            // Filter Buttons
            HStack(spacing: 16) {
                SearchFilterButtonView(
                    icon: IconConstants.lesson,
                    label: "Lessons",
                    isSelected: viewModel.showLessons,
                    action: {
                        viewModel.toggleFilter(for: .lessons)
                    }
                )
                
                SearchFilterButtonView(
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
        .padding(.vertical, 5)
        .background(ThemeConstants.verticalGradient)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
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

class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var cellViewModels: [LearningContentMetadataViewModel] = []
    @Published var query: String = "" {
        didSet {
            performSearch()
        }
    }
    @Published var showLessons: Bool = true {
        didSet {
            performSearch()
        }
    }
    @Published var showModules: Bool = true {
        didSet {
            performSearch()
        }
    }
    
    private let contentProvider: any KHDomainContentProviderProtocol
    private let mainTabViewModel: MainTabViewModel?
    
    private lazy var defaultModules: [LearningModule] = {
        contentProvider.activeTopModule.levelOrderModules
    }()
    
    private lazy var defaultLessons: [LearningContent] = {
        contentProvider.activeTopModule.preOrderLessons
    }()
    
    // MARK: - Initialization
    init(contentProvider: any KHDomainContentProviderProtocol, mainTabViewModel: MainTabViewModel? = nil) {
        self.contentProvider = contentProvider
        self.mainTabViewModel = mainTabViewModel
        loadDefaultContent()
    }
    
    // MARK: - Default Content Loading
    func loadDefaultContent() {
        let contents = (showModules ? defaultModules : []) + (showLessons ? defaultLessons : [])
        cellViewModels = contents.map { LearningContentMetadataViewModel(content: $0) }
    }
    
    // MARK: - Search Functionality
    private func performSearch() {
        guard !query.isEmpty else {
            loadDefaultContent()
            return
        }
        
        let searchResults = contentProvider.searchContent(with: query)
        var filteredResults = searchResults
        
        if !showLessons {
            filteredResults = filteredResults.filter { !($0 is Lesson) }
        }
        if !showModules {
            filteredResults = filteredResults.filter { !($0 is LearningModule) }
        }
        
        cellViewModels = filteredResults.map { LearningContentMetadataViewModel(content: $0) }
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

enum FilterType {
    case lessons
    case modules
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
