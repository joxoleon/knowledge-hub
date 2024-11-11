//
//  MainTabView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24.
//

import SwiftUI
import KHBusinessLogic
import Combine

enum NavigationTarget: Hashable, Equatable {
    case lessonDetail(LessonDetailsViewModel)
    case moduleDetail(LearningModuleDetailsViewModel)
    case customCollectionView(CustomContentCollectionViewModel)
    case quiz(QuizViewModel)
    case flashcards
    case readLesson(LessonViewModel)
}

struct MainTabView: View {
    @StateObject var viewModel: MainTabViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            NavigationStack(path: $viewModel.searchNavigationStack) {
                SearchView(viewModel: viewModel.searchViewModel)
                    .navigationDestination(for: NavigationTarget.self) { destination in
                        destinationView(for: destination)
                    }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(MainTabViewModel.Tab.search)
            
            NavigationStack(path: $viewModel.browseNavigationStack) {
                BrowseView(viewModel: viewModel.browseViewModel)
                    .navigationDestination(for: NavigationTarget.self) { destination in
                        destinationView(for: destination)
                    }
            }
            .tabItem {
                Image(systemName: "rectangle.grid.2x2.fill")
                Text("Browse")
            }
            .tag(MainTabViewModel.Tab.browse)
            
            NavigationStack(path: $viewModel.progressNavigationStack) {
                MyProgressView(viewModel: viewModel.myProgressViewModel)
                    .navigationDestination(for: NavigationTarget.self) { destination in
                        destinationView(for: destination)
                    }
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Progress")
            }
            .tag(MainTabViewModel.Tab.progress)
        }
        .accentColor(Color.titleGold)
    }
    
    @ViewBuilder
    private func destinationView(for destination: NavigationTarget) -> some View {
        switch destination {
        case .lessonDetail(let viewModel):
            LessonDetailView(viewModel: viewModel)
        case .moduleDetail(let viewModel):
            LearningModuleDetailView(viewModel: viewModel)
        case .customCollectionView(let viewModel):
            CustomContentCollectionView(viewModel: viewModel)
        case .quiz:
            Text("Quiz View") // Replace with actual quiz view
        case .flashcards:
            Text("Flashcards View") // Replace with actual flashcards view
        case .readLesson:
            Text("Read Lesson View") // Replace with actual read lesson view
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
    @Published var searchNavigationStack: [NavigationTarget] = []
    @Published var browseNavigationStack: [NavigationTarget] = []
    @Published var progressNavigationStack: [NavigationTarget] = []
    @Published var searchViewModel: SearchViewModel!
    @Published var browseViewModel: BrowseViewModel!
    @Published var myProgressViewModel: MyProgressViewModel!

    // MARK: - Private Properties
    private var contentProvider: any KHDomainContentProviderProtocol
    
    // MARK: - Initializer
    init(contentProvider: any KHDomainContentProviderProtocol) {
        self.contentProvider = contentProvider
        
        // Initialize view models directly since contentProvider is already initialized
        self.searchViewModel = SearchViewModel(contentProvider: contentProvider, mainTabViewModel: self)
        self.browseViewModel = BrowseViewModel(contentProvider: contentProvider, mainTabViewModel: self)
        self.myProgressViewModel = MyProgressViewModel(contentProvider: contentProvider, mainTabViewModel: self)
    }
    
    // MARK: - Navigation Control
    
    func navigateToLearningContent(content: any LearningContent) {
        print("Navigating to content: \(content.title)")
        if let lesson = content as? Lesson {
            let lessonDetailViewModel = LessonDetailsViewModel(lesson: lesson, mainTabViewModel: self)
            navigateTo(.lessonDetail(lessonDetailViewModel))
        } else if let module = content as? LearningModule {
            let moduleDetailViewModel = LearningModuleDetailsViewModel(module: module, mainTabViewModel: self)
            navigateTo(.moduleDetail(moduleDetailViewModel))
        }
    }
    
    func navigateToCustomCollectionView(viewModel: CustomContentCollectionViewModel) {
        navigateTo(.customCollectionView(viewModel))
    }
    
    public func navigateTo(_ target: NavigationTarget) {
        switch selectedTab {
        case .search:
            searchNavigationStack.append(target)
        case .browse:
            browseNavigationStack.append(target)
        case .progress:
            progressNavigationStack.append(target)
        }
    }
    
    public func popNavigationTarget() {
        switch selectedTab {
        case .search:
            if !searchNavigationStack.isEmpty {
                searchNavigationStack.removeLast()
            }
        case .browse:
            if !browseNavigationStack.isEmpty {
                browseNavigationStack.removeLast()
            }
        case .progress:
            if !progressNavigationStack.isEmpty {
                progressNavigationStack.removeLast()
            }
        }
    }
}
