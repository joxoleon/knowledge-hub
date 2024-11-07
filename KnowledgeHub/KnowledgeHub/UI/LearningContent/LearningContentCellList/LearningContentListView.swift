////
////  LearningContentListView.swift
////  KnowledgeHub
////
////  Created by Jovan Radivojsa on 5.11.24..
////
//
//import SwiftUI
//import KHBusinessLogic
//
//struct LearningContentListView: View {
//    @ObservedObject var viewModel: LearningContentListViewModel
//    @EnvironmentObject var colorManager: ColorManager
//
//    var body: some View {
//        List(viewModel.cellViewModels, id: \.id) { cellViewModel in
//            LearningContentCellView(viewModel: cellViewModel)
//                .environmentObject(colorManager)
//                .listRowInsets(EdgeInsets()) // Removes default padding around each cell
//                .padding(.bottom, 3) // Custom padding between cells
//                .background(Color.black) // Allows cell background gradient to show
//        }
//        .listStyle(PlainListStyle()) // Use plain style for a cleaner look
//        .onAppear {
//            viewModel.refreshLearningContents()
//        }
//    }
//}
//
//// Preview for LearningContentListView
//#Preview {
//    let learningContents: [any LearningContent] = [Testing.testModule, Testing.testLesson]
//    let viewModel = LearningContentListViewModel(learningContents: learningContents)
//    
//    ZStack {
//        Color.black
//            .edgesIgnoringSafeArea(.all)
//        
//        LearningContentListView(viewModel: viewModel)
//            .environmentObject(ColorManager(colorTheme: .midnightBlue))
//    }
//}
