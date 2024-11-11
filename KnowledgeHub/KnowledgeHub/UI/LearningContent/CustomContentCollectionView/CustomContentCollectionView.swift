// CustomContentCollectionView.swift
// KnowledgeHub
//
// Created by Jovan Radivojsa on 10.11.24.
//

import SwiftUI
import KHBusinessLogic

fileprivate enum CollectionViewConstants {
    static let primaryIconSize: CGFloat = 50.0
}

struct CustomContentCollectionView: View {
    @ObservedObject var viewModel: CustomContentCollectionViewModel
    @State private var isQuizPresented = false
    @State private var isFlashcardsPresented = false

    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text(viewModel.title)
                .font(.title)
                .foregroundColor(.titleGold)
                .padding(.top, 16)
            
            // Description
            Text(viewModel.description)
                .foregroundColor(.textColor)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            // Action Buttons
            HStack(spacing: 16) {
                KHActionButton(
                    iconName: IconConstants.flashcardsAction,
                    iconSize: CollectionViewConstants.primaryIconSize,
                    title: "Flashcards",
                    fontColor: .titleGold,
                    action: { self.isFlashcardsPresented.toggle() }
                )
                
                Spacer()
                
                KHActionButton(
                    iconName: IconConstants.quizAction,
                    iconSize: CollectionViewConstants.primaryIconSize,
                    title: "Quiz",
                    fontColor: .titleGold,
                    action: { self.isQuizPresented.toggle() }
                )
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 30)
            .padding(.top, 12)
            
            // Learning Content List
            LearningContentsListView(
                viewModel: viewModel.learningContentsListViewModel
            )
            .padding(.horizontal)
        }
        .padding(.bottom, 16)
        .background(ThemeConstants.verticalGradient)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $isFlashcardsPresented) {
            viewModel.flashCardsView(isPresented: $isFlashcardsPresented)
        }
        .fullScreenCover(isPresented: $isQuizPresented) {
            viewModel.quizView(isPresented: $isQuizPresented)
        }
    }
}

// MARK: - ViewModel
class CustomContentCollectionViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var learningContentsListViewModel: LearningContentsListViewModel
    
    let title: String
    let description: String
    let contents: [LearningContent]
    let mainTabViewModel: MainTabViewModel?
    var showFilters: Bool

    // MARK: - Initialization
    init(
        title: String,
        description: String,
        contents: [LearningContent],
        showFilters: Bool,
        mainTabViewModel: MainTabViewModel?
    ) {
        self.title = title
        self.description = description
        self.learningContentsListViewModel = LearningContentsListViewModel(
            content: contents,
            mainTabViewModel: mainTabViewModel,
            showFilterButtons: showFilters)
        self.showFilters = showFilters
        self.mainTabViewModel = mainTabViewModel
        self.contents = contents
    }
    
    // MARK: - Methods
    
    func quizView(isPresented: Binding<Bool>) -> some View {
        Group {
            if let contentProvider = contents.first?.contentProvider {
                let questions = contents.map { $0.questions }.flatMap { $0 }
                var containmentSet = Set<String>()
                let uniqueQuestions = questions.filter { containmentSet.insert($0.id).inserted }
                
                let quiz = QuizImpl(
                    id: self.title + "quiz",
                    questions: uniqueQuestions,
                    contentProvider: contentProvider)
                QuizView(viewModel: QuizViewModel(quiz: quiz), isPresented: isPresented)
            } else {
                EmptyView() // Placeholder view if contentProvider is nil
            }
        }
    }

    func flashCardsView(isPresented: Binding<Bool>) -> some View {
        
        let cards = contents.map{ $0.summaries }.flatMap { $0 }
        var containmentSet = Set<String>()
        let uniqueCards = cards.filter { containmentSet.insert($0).inserted }
        return FlashCardView(cards: uniqueCards, isPresented: isPresented)
    }
}

extension CustomContentCollectionViewModel : Equatable, Hashable {
    static func == (lhs: CustomContentCollectionViewModel, rhs: CustomContentCollectionViewModel) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
    }
}
    

// MARK: - Preview
struct CustomContentCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CustomContentCollectionViewModel(
            title: "Starred Content",
            description: "You can see the overview of the content you starrred, blah blah.",
            contents: Testing.contentProvider.activeTopModule.preOrderLessons + Testing.contentProvider.activeTopModule.levelOrderModules,
            showFilters: true,
            mainTabViewModel: nil
        )
        
        CustomContentCollectionView(viewModel: viewModel)
    }
}
