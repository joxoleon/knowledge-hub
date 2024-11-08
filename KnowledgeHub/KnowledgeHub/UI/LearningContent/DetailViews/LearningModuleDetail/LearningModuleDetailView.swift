import SwiftUI
import KHBusinessLogic

fileprivate enum Constants {
    static let primaryIconSize: CGFloat = 60.0
    static let regularIconSize: CGFloat = 45.0
}

struct LearningModuleDetailView: View {
    @ObservedObject var viewModel: LearningModuleDetailsViewModel
    @State private var isQuizPresented = false
    
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
                        isQuizPresented = true
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
                        NavigationLink(
                            destination: destinationView(for: .lessonDetail),
                            isActive: Binding(
                                get: { viewModel.currentNavigationTarget == .lessonDetail },
                                set: { isActive in
                                    if !isActive { viewModel.currentNavigationTarget = nil }
                                }
                            )
                        ) {
                            LearningContentCellView(viewModel: cellViewModel)
                                .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(10)
        .background(ThemeConstants.verticalGradient.ignoresSafeArea())
        .fullScreenCover(isPresented: $isQuizPresented) {
            viewModel.quizView(isPresented: $isQuizPresented)
        }
        .onAppear {
            viewModel.refreshData()
        }
        .navigationDestination(for: NavigationDestination.self) { destination in
            destinationView(for: destination)
        }
    }
    
    // MARK: - Navigation Destination
    
    @ViewBuilder
    private func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
        case .lessonDetail:
            if let lessonViewModel = viewModel.lessonDetailViewModel {
                LessonDetailView(viewModel: lessonViewModel)
            }
        case .moduleDetail:
            if let moduleViewModel = viewModel.learningModuleDetailViewModel {
                LearningModuleDetailView(viewModel: moduleViewModel)
            }
        case .quiz:
            Text("Quiz View") // Replace with actual quiz view
        case .flashcards:
            Text("Flashcards View") // Replace with actual flashcards view
        }
    }
}
