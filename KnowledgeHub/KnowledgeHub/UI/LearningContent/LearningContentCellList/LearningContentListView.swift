////
////  LearningContentListView.swift
////  KnowledgeHub
////
////  Created by Jovan Radivojsa on 5.11.24..
////
//
//import SwiftUI
//
//import SwiftUI
//import KHBusinessLogic
//
//struct LearningContentListView: View {
//    @ObservedObject var viewModel: LearningContentListViewModel
//    @EnvironmentObject var colorManager: ColorManager
//
//    var body: some View {
//        List(viewModel.learningContents, id: \.id) { content in
//            LearningContentCellView(learningContent: content)
//                .environmentObject(colorManager)
//                .listRowInsets(EdgeInsets()) // Removes default padding around each cell
//                .padding(.bottom, 3) // Custom padding between cells
//                .background(Color.black) // To allow background gradient from cell to show
//        }
//        .listStyle(PlainListStyle()) // Use plain style for a cleaner look
//        
//    }
//}
//
//
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
//
//}
