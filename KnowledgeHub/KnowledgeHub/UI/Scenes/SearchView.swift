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
                    TextField("Search...", text: $query, onCommit: {
                        viewModel.performSearch(with: query)
                    })
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.titleGold)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(ThemeConstants.cellGradient))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.titleGold.opacity(0.8), lineWidth: 1))
                }
                .padding([.horizontal, .top])
                
                // Filter Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        toggleFilter(&showLessons, otherFilter: &showModules)
                    }) {
                        SearchFilterButtonView(icon: IconConstants.lesson, isSelected: showLessons)
                    }
                    
                    Button(action: {
                        toggleFilter(&showModules, otherFilter: &showLessons)
                    }) {
                        Text("Modules")
                            .foregroundColor(showModules ? .titleGold : .placeholderGray)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(showModules ? 0.2 : 0.1)))
                    }
                }
                .padding(.horizontal)
                
                // Results List
                List {
                    if showLessons {
                        ForEach(viewModel.searchResultsLessons, id: \.id) { lesson in
                            Text(lesson.title) // Customize to display more details as needed
                        }
                    }
                    if showModules {
                        ForEach(viewModel.searchResultsModules, id: \.id) { module in
                            Text(module.title) // Customize to display more details as needed
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
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
    
    struct SearchFilterButtonView: View {
        
        @State var icon: String
        @State var isSelected: Bool = true
        
        var body: some View {
            HStack {
                Image(systemName: IconConstants.lesson)
                    .foregroundColor(isSelected ? .titleGold : .placeholderGray)
                    .font(.title2)
                    .padding(.vertical, 6)
                    .padding(.leading, 6)
                
                Text("Lessons")
                    .foregroundColor(isSelected ? .titleGold : .placeholderGray)
                    .padding(.trailing, 8)
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(ThemeConstants.cellGradient))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.titleGold.opacity(isSelected ? 0.5 : 0.2), lineWidth: 1))
            
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

fileprivate enum SearchConstants {
    static let relevanceThreshold = 0.2
}

class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var searchResultsLessons: [Lesson] = []
    @Published var searchResultsModules: [LearningModule] = []
    
    private let contentProvider: any KHDomainContentProviderProtocol
    
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
