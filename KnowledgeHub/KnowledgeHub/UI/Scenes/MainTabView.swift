//
//  MainTabView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI
import KHBusinessLogic

struct MainTabView: View {
    @StateObject var viewModel: MainTabViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            NavigationView {
                SearchView(viewModel: viewModel.searchViewModel)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(MainTabViewModel.Tab.search)
            
            NavigationView {
                BrowseView(viewModel: viewModel.browseViewModel)
            }
            .tabItem {
                Image(systemName: "rectangle.grid.2x2.fill")
                Text("Browse")
            }
            .tag(MainTabViewModel.Tab.browse)
            
            NavigationView {
                MyProgressView(viewModel: viewModel.myProgressViewModel)
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Progress")
            }
            .tag(MainTabViewModel.Tab.progress)
        }
        .accentColor(Color.titleGold)
    }
}

class MainTabViewModel: ObservableObject {
    
    // MARK: - Types
    enum Tab {
        case search, browse, progress
    }

    // MARK: - Public Properties
    @Published var selectedTab: Tab = .browse
    @Published var searchViewModel: SearchViewModel
    @Published var browseViewModel: BrowseViewModel
    @Published var myProgressViewModel: MyProgressViewModel
    
    // MARK: - Private Properties
    private var contentProvider: any KHDomainContentProviderProtocol
    
    // MARK: - Initializer
    init(contentProvider: any KHDomainContentProviderProtocol) {
        self.contentProvider = contentProvider
        
        // Initialize view models directly since contentProvider is already initialized
        self.searchViewModel = SearchViewModel()
        self.browseViewModel = BrowseViewModel(contentProvider: contentProvider)
        self.myProgressViewModel = MyProgressViewModel()
    }
}
