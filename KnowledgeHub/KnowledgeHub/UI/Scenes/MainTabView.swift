//
//  MainTabView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI
import KHBusinessLogic
import Combine

struct MainTabView: View {
    @StateObject var viewModel: MainTabViewModel

    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedTab) {
                SearchView(viewModel: viewModel.searchViewModel)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(MainTabViewModel.Tab.search)
                
                BrowseView(viewModel: viewModel.browseViewModel)
                    .tabItem {
                        Image(systemName: "rectangle.grid.2x2.fill")
                        Text("Browse")
                    }
                    .tag(MainTabViewModel.Tab.browse)
                
                MyProgressView(viewModel: viewModel.myProgressViewModel)
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Progress")
                    }
                    .tag(MainTabViewModel.Tab.progress)
            }
            .accentColor(Color.titleGold)
            .navigationDestination(for: NavigationTarget.self) { destination in
                destinationView(for: destination)
            }
        }
    }
    
    @ViewBuilder
    private func destinationView(for destination: NavigationTarget) -> some View {
        switch destination {
        case .lessonDetail(let viewModel):
            LessonDetailView(viewModel: viewModel)
        case .moduleDetail(let viewModel):
            LearningModuleDetailView(viewModel: viewModel)
        case .quiz:
            Text("Quiz View") // Replace with actual quiz view
        case .flashcards:
            Text("Flashcards View") // Replace with actual flashcards view
        }
    }
}

class MainTabViewModel: ObservableObject {
    
    // MARK: - Types
    enum Tab {
        case search, browse, progress
    }

    // MARK: - Public Properties
    @Published var selectedTab: Tab = .browse
    @Published var searchViewModel: SearchViewModel!
    @Published var browseViewModel: BrowseViewModel!
    @Published var myProgressViewModel: MyProgressViewModel!
    @Published var navigationTarget: NavigationTarget? {
        didSet {
            print("*** Navigation Target: \(String(describing: navigationTarget)) ***")
        }
    }

    // MARK: - Private Properties
    private var contentProvider: any KHDomainContentProviderProtocol
    
    // MARK: - Initializer
    init(contentProvider: any KHDomainContentProviderProtocol) {
        self.contentProvider = contentProvider
        
        // Initialize view models directly since contentProvider is already initialized
        self.searchViewModel = SearchViewModel()
        self.browseViewModel = BrowseViewModel(contentProvider: contentProvider, mainTabViewModel: self)
        self.myProgressViewModel = MyProgressViewModel()
    }
    
    // MARK: - Navigation Control
    
    public func navigateTo(_ target: NavigationTarget) {
        print("*** navigateTo target invoked for: \(target) ***")
        navigationTarget = target
    }
}
