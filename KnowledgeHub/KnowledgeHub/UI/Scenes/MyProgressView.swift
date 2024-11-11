
//  BrowseView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 7.11.24..
//

import SwiftUI
import Combine
import KHBusinessLogic

struct MyProgressView: View {
    @ObservedObject var viewModel: MyProgressViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ProgressMetadataView(viewModel: viewModel.progressMetadataViewModel)
                    .padding(.vertical)
                
                SeparatorView()
                
                VStack(spacing: 10) {
                    navigationButtonView(
                        isButtonLeft: true,
                        icon: IconConstants.starAction,
                        iconTitle: "Starred",
                        description: "Check out all of the content that you marked as important."
                    ) {
                        viewModel.navigateToStarredContent()
                    }
                    
                    SeparatorView()
                    
                    navigationButtonView(
                        isButtonLeft: false,
                        icon: IconConstants.improvementIcon,
                        iconTitle: "Improve",
                        description: "Go over the lessons that you need to improve on and get a better score."
                    ) {
                        viewModel.navigateToImproveScoreContent()
                    }
                    
                    SeparatorView()
                    
                    navigationButtonView(
                        isButtonLeft: true,
                        icon: IconConstants.continueAction,
                        iconTitle: "Continue",
                        description: "Resume from where you left off or start a new lesson."
                    ) {
                        viewModel.navigateToContinue()
                    }
                    
                    SeparatorView()
                    
                    navigationButtonView(
                        isButtonLeft: false,
                        icon: IconConstants.repeatAction,
                        iconTitle: "Retake",
                        description: "You did it! Still, it can't hurt to brush up on existing knowledge."
                    ) {
                        viewModel.navigateToRetake()
                    }
                    
                    SeparatorView()
                }
            }
        }
        .padding(.bottom, 5)
        .background(ThemeConstants.verticalGradient)
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
    
    
    private func navigationButtonView(isButtonLeft: Bool, icon: String, iconTitle: String, description: String, action: @escaping () -> Void) -> some View {
        let buttonView =
        KHActionButton(
            iconName: icon,
            iconSize: 55.0,
            title: iconTitle,
            fontColor: .titleGold
        ) {
            action()
        }
        
        let descriptionView =
        Text(description)
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .foregroundColor(.textColor)
        
        return HStack {
            if isButtonLeft {
                buttonView
            } else {
                descriptionView
            }
            
            Spacer()
            
            if isButtonLeft {
                descriptionView
            } else {
                buttonView
            }
        }
        .padding(.horizontal, 30)
    }
}

class MyProgressViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var progressMetadataViewModel: ProgressMetadataViewModel
    
    private let contentProvider: any KHDomainContentProviderProtocol
    private let mainTabViewModel: MainTabViewModel?
    
    // MARK: - Initialization
    
    init(contentProvider: any KHDomainContentProviderProtocol, mainTabViewModel: MainTabViewModel?) {
        self.contentProvider = contentProvider
        self.mainTabViewModel = mainTabViewModel
        self.progressMetadataViewModel = ProgressMetadataViewModel(contentProvider: contentProvider)
    }
    
    // MARK: - Navigation
    
    func navigateToStarredContent() {
        // Fetch all learning contents and filter out the starred ones
        let allLearningContents: [any LearningContent] = [contentProvider.activeTopModule] + contentProvider.activeTopModule.recursiveLearningContents
        let starredContent = allLearningContents.filter { $0.isStarred }
        
        // Construct the appropaite view model and navigate to it's custom collection view
        mainTabViewModel?.navigateToCustomCollectionView(
            viewModel: CustomContentCollectionViewModel(
                title: "Starred",
                description: "Check out all of the content that you marked as important.",
                contents: starredContent,
                showFilters: true,
                mainTabViewModel: mainTabViewModel
            )
        )
    }
    
    func navigateToImproveScoreContent() {
        let imperfectLessons = contentProvider.activeTopModule.preOrderLessons.filter { $0.score ?? 101.0 < 100.0 }
        
        // Construct the appropaite view model and navigate to it's custom collection view
        mainTabViewModel?.navigateToCustomCollectionView(
            viewModel: CustomContentCollectionViewModel(
                title: "Improve",
                description: "Go over the lessons that you need to improve on and get a better score.",
                contents: imperfectLessons,
                showFilters: true,
                mainTabViewModel: mainTabViewModel
            )
        )
    }
    
    func navigateToContinue() {
        let unfinishedLesson = contentProvider.activeTopModule.preOrderLessons.first { !$0.isComplete }
        guard let lesson = unfinishedLesson else { return }
        mainTabViewModel?.navigateToLearningContent(content: lesson)
    }
    
    func navigateToRetake() {
        let completedLessons = contentProvider.activeTopModule.preOrderLessons.filter { $0.isComplete }
        
        // Construct the appropaite view model and navigate to it's custom collection view
        mainTabViewModel?.navigateToCustomCollectionView(
            viewModel: CustomContentCollectionViewModel(
                title: "Retake",
                description: "You did it! Still, it can't hurt to brush up on existing knowledge.",
                contents: completedLessons,
                showFilters: true,
                mainTabViewModel: mainTabViewModel
            )
        )
    }
    
}

// Add preview
struct MyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let contentProvider = Testing.contentProvider
        let viewModel = MyProgressViewModel(contentProvider: contentProvider, mainTabViewModel: nil)
        
        ZStack {
            ThemeConstants.verticalGradient
                .edgesIgnoringSafeArea(.all)
            
            MyProgressView(viewModel: viewModel)
        }
    }
}
