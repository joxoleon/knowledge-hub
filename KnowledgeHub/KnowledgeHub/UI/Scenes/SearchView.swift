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
            
            // Filtered Learning Content List
            LearningContentsListView(viewModel: LearningContentsListViewModel(content: viewModel.learningContents, mainTabViewModel: viewModel.mainTabViewModel, showFilterButtons: true))
        }
        .padding(.bottom, 5)
        .background(ThemeConstants.verticalGradient.ignoresSafeArea())
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

class SearchViewModel: ObservableObject {
    
    
    // MARK: - Properties
    @Published public var learningContents: [LearningContent] = []
    @Published var query: String = "" {
        didSet {
            performSearch()
        }
    }
    
    let contentProvider: any KHDomainContentProviderProtocol
    let mainTabViewModel: MainTabViewModel?
    
    
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
        learningContents = defaultModules + defaultLessons
    }
    
    // MARK: - Search Functionality
    private func performSearch() {
        guard !query.isEmpty else {
            loadDefaultContent()
            return
        }
        
        learningContents = contentProvider.searchContent(with: query)
    }
}
