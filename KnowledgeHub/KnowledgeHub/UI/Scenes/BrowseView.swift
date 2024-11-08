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
        LearningModuleDetailView(
            viewModel: viewModel.learningModuleDetailViewModel
        )
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
    }
}


class BrowseViewModel: ObservableObject {
    @Published var learningModuleDetailViewModel: LearningModuleDetailsViewModel
    
    init(contentProvider: any KHDomainContentProviderProtocol) {
        let topLevelModule = contentProvider.activeTopModule
        self.learningModuleDetailViewModel = LearningModuleDetailsViewModel(module: topLevelModule)
    }
    
    func navigateToContent(content: any LearningContent) {
        learningModuleDetailViewModel.navigateToLearningContent(content: content)
    }
}
