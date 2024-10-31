import Foundation

public enum CompletionStatus {
    case notStarted
    case inProgress
    case completed
}

protocol LearningContent: AnyObject {
    var id: String { get }
    var title: String { get }
    var description: String? { get }
    var questions: [Question] { get }
    var quiz: Quiz { get }
    
    var completionStatus: CompletionStatus { get }
    var completionPercentage: Double { get }
    var score: Double? { get }
}

extension LearningContent {
    var completionStatus: CompletionStatus {
        quiz.completionStatus
    }
    
    var completionPercentage: Double {
        quiz.completionPercentage
    }
    
    var score: Double? {
        quiz.quizScore
    }
}
