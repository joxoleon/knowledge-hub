//
//  BrowseView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import Combine
import SwiftUI
import KHBusinessLogic

struct BrowseView: View {
    @ObservedObject var viewModel: BrowseViewModel
    
    var body: some View {
        LearningModuleDetailView(viewModel: viewModel.learningModuleDetailViewModel)
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
}


class BrowseViewModel: ObservableObject {
    @Published var learningModuleDetailViewModel: LearningModuleDetailsViewModel
    private var mainTabViewModel: MainTabViewModel
    
    init(contentProvider: any KHDomainContentProviderProtocol, mainTabViewModel: MainTabViewModel) {
        self.mainTabViewModel = mainTabViewModel
        
        let topLevelModule = contentProvider.activeTopModule
        self.learningModuleDetailViewModel = LearningModuleDetailsViewModel(module: topLevelModule, mainTabViewModel: mainTabViewModel)
    }
}
