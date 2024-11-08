import SwiftUI
import KHBusinessLogic

fileprivate enum Constants {
    static let primaryIconSize: CGFloat = 60.0
    static let regularIconSize: CGFloat = 45.0
}

struct LearningModuleDetailView: View {
    @ObservedObject var viewModel: LearningModuleDetailsViewModel

    var body: some View {
        ScrollView {
            VStack {
                // Metadata View
                LearningContentMetadataView(viewModel: viewModel.learningContentMetadataViewModel)
                    .padding(.vertical)
                
                // Action Buttons Row
                HStack {
                    KHActionButton(
                        iconName: "bolt.circle.fill",
                        iconSize: Constants.regularIconSize,
                        title: "Flashcards",
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
                        viewModel.navigateToNextLesson()
                    }
                    .offset(y: -Constants.primaryIconSize * 0.8)

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
                .padding(.horizontal, 25)
                .padding(.top, 55)
                .padding(.bottom, 25)
                
                // Contents Title
                Text("Contents:")
                    .font(.system(size: 14))
                    .fontWeight(.heavy)
                    .foregroundColor(.titleGold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SeparatorView()
                
                // Contents List with NavigationLink
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(viewModel.cellViewModels, id: \.id) { cellViewModel in
                        LearningContentCellView(viewModel: cellViewModel)
                            .cornerRadius(8)
                            .onTapGesture {
                                viewModel.navigateToLearningContent(content: cellViewModel.content)
                            }
                    }
                }
            }
        }
        .padding(10)
        .background(ThemeConstants.verticalGradient.ignoresSafeArea())
        .onAppear {
            viewModel.refreshData()
        }
    }
}
