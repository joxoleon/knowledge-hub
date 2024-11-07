//
//  LearningModuleDetailView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 5.11.24..
//

import SwiftUI

fileprivate enum Constants {
    static let primaryIconSize: CGFloat = 55.0
    static let regularIconSize: CGFloat = 40.0
}

struct LearningModuleDetailView: View {
    @ObservedObject var learningContentMetadataViewModel: LearningContentMetadataViewModel
    @ObservedObject var viewModel: LearningModuleDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack() {
                // Metadata View
                LearningContentMetadataView(viewModel: learningContentMetadataViewModel)
                    .padding(.vertical)

                // Contents Title
                Text("Contents:")
                    .font(.system(size: 14))
                    .fontWeight(.heavy)
                    .foregroundColor(.titleGold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SeparatorView()
                
                // Contents List
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(viewModel.contentListViewModel.cellViewModels, id: \.id) { cellViewModel in
                        LearningContentCellView(viewModel: cellViewModel)
                            .background(Color.black.opacity(0.5)) // Adjust background as needed
                            .cornerRadius(8)
                    }
                }
                
                SeparatorView()
                
                
                // Action Buttons Row
                HStack {
                    KHActionButton(
                        iconName: "bolt.circle.fill",
                        iconSize: Constants.regularIconSize,
                        title: "Flashcard",
                        fontColor: .titleGold
                    ) {
                        viewModel.navigateToFlashcards()
                    }
                    Spacer()

                    KHActionButton(
                        iconName: "play.circle.fill",
                        iconSize: Constants.primaryIconSize,
                        title: viewModel.startOrContinueTitle,
                        fontColor: .titleGold
                    ) {
                        viewModel.startOrContinueLearning()
                    }
                    .offset(y: -Constants.primaryIconSize * 0.6)

                    Spacer()

                    KHActionButton(
                        iconName: "questionmark.circle.fill",
                        iconSize: Constants.regularIconSize,
                        title: "Quiz",
                        fontColor: .titleGold
                    ) {
                        viewModel.navigateToQuiz()
                    }
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
            }
        }
        .padding(10)
        .background(ThemeConstants.verticalGradient.ignoresSafeArea())
    }
}

struct LearningModuleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .edgesIgnoringSafeArea(.all)
            
            LearningModuleDetailView(
                learningContentMetadataViewModel: LearningContentMetadataViewModel(content: Testing.testModule),
                viewModel: LearningModuleDetailsViewModel(module: Testing.testModule)
            )
        }
    }
}
