import KHContentSource
import XCTest

@testable import KHBusinessLogic

class KHDomainContentProviderTests: XCTestCase {

    private func instantiateContentProvider() -> KHDomainContentProvider {
        let contentRepository = ContentRepository(
            fetcher: GitHubContentFetcher(), storage: FileContentStorage())
        let progressTrackingRepository = InMemoryProgressTrackingRepository.placeholder
        let starTrackingRepository = InMemoryStarTrackingRepository.placeholder
        return KHDomainContentProvider(
            contentRepository: contentRepository,
            progressTrackingRepository: progressTrackingRepository,
            starTrackingRepository: starTrackingRepository)
    }

    func testKHDomainContentProviderUsage() async throws {

        // Setup
        let contentProvider = instantiateContentProvider()
        try await contentProvider.initializeContent()

        // fetch module
        let topLevelModules = contentProvider.getTopLevelModules()
        XCTAssertFalse(topLevelModules.isEmpty)
        let iOSModule = topLevelModules.first!

        // MARK: - Progress Tests

        // Assert learning module properties (isComplete, completionPercentage, score)
        XCTAssertFalse(iOSModule.isComplete)
        XCTAssertEqual(iOSModule.completionStatus, .notStarted)
        XCTAssertEqual(iOSModule.completionPercentage, 0.0)
        XCTAssertNil(iOSModule.score)

        // Answer four questions wrongly
        answerModuleQuestions(module: iOSModule, numberOfQuestions: 4, correctness: false)
        XCTAssertFalse(iOSModule.isComplete)
        XCTAssertEqual(iOSModule.completionStatus, .inProgress)
        XCTAssertEqual(iOSModule.completionPercentage, 100.0 / Double(iOSModule.quiz.questions.count) * 4)
        XCTAssertEqual(iOSModule.score, 0.0)

        // Only two questions answered correctly
        answerModuleQuestions(module: iOSModule, numberOfQuestions: 2, correctness: true)
        XCTAssertFalse(iOSModule.isComplete)
        XCTAssertEqual(iOSModule.completionStatus, .inProgress)
        XCTAssertEqual(iOSModule.completionPercentage, 100.0 / Double(iOSModule.quiz.questions.count) * 4)
        XCTAssertEqual(iOSModule.score, 50.0)

        // All questions are answered correctly
        answerModuleQuestions(module: iOSModule, numberOfQuestions: iOSModule.quiz.questions.count, correctness: true)
        XCTAssertTrue(iOSModule.isComplete)
        XCTAssertEqual(iOSModule.completionPercentage, 100.0)
        XCTAssertEqual(iOSModule.score, 100.0)

        // All questions are answered incorrectly
        answerModuleQuestions(module: iOSModule, numberOfQuestions: iOSModule.quiz.questions.count, correctness: false)
        XCTAssertTrue(iOSModule.isComplete)
        XCTAssertEqual(iOSModule.completionPercentage, 100.0)
        XCTAssertEqual(iOSModule.score, 0.0)

        // MARK: - Star Tests

        // Star top level module recursively
        iOSModule.starContentsRecursively()
        XCTAssertTrue(iOSModule.isStarred)
        iOSModule.learningContents.forEach { XCTAssertTrue($0.isStarred) }

        // Unstar top level module recursively
        iOSModule.unstarContentsRecursively()
        XCTAssertFalse(iOSModule.isStarred)
        iOSModule.learningContents.forEach { XCTAssertFalse($0.isStarred) }        
    }

    private func answerModuleQuestions(
        module: KHBusinessLogic.LearningModule, numberOfQuestions: Int, correctness: Bool
    ) {
        let quiz = module.quiz
        let questions = quiz.questions
        for i in 0..<numberOfQuestions {
            guard let question = questions[i] as? MultipleChoiceQuestion else {
                XCTFail("Question is not of type MultipleChoiceQuestion")
                return
            }
            let answer = question.answers[
                correctness
                    ? question.correctAnswerIndex
                    : (question.correctAnswerIndex + 1) % question.answers.count]
            let _ = question.submitAnswer(answer)

        }
    }
}
