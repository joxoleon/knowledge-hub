
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
                        print("Starred Content")
                    }
                    
                    SeparatorView()
                    
                    navigationButtonView(
                        isButtonLeft: false,
                        icon: IconConstants.improvementIcon,
                        iconTitle: "Improve",
                        description: "Go over the lessons that you need to improve on and get a better score."
                    ) {
                        print("Improve Score")
                    }
                    
                    SeparatorView()
                    
                    navigationButtonView(
                        isButtonLeft: true,
                        icon: IconConstants.continueAction,
                        iconTitle: "Continue",
                        description: "Resume from where you left off or start a new lesson."
                    ) {
                        print("First Unstarted Lesson")
                    }
                    
                    SeparatorView()
                    
                    navigationButtonView(
                        isButtonLeft: false,
                        icon: IconConstants.repeatAction,
                        iconTitle: "Retake",
                        description: "You did it! Still, it can't hurt to brush up on existing knowledge."
                    ) {
                        print("Contents")
                    }
                    
                    SeparatorView()
                }
            }
        }
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
    @Published var progressMetadataViewModel: ProgressMetadataViewModel
    
    private let contentProvider: any KHDomainContentProviderProtocol
    private let mainTabViewModel: MainTabViewModel?
    
    // MARK: - Initialization
    init(contentProvider: any KHDomainContentProviderProtocol, mainTabViewModel: MainTabViewModel?) {
        self.contentProvider = contentProvider
        self.mainTabViewModel = mainTabViewModel
        self.progressMetadataViewModel = ProgressMetadataViewModel(contentProvider: contentProvider)
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
