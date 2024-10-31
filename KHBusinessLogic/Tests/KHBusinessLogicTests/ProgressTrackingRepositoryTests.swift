import XCTest
@testable import KHBusinessLogic

final class ProgressTrackingRepositoryTests: XCTestCase {
    
    var inMemoryRepository: InMemoryProgressTrackingRepository!
    var userDefaultsRepository: UserDefaultsProgressTrackingRepository!
    
    override func setUp() {
        super.setUp()
        inMemoryRepository = InMemoryProgressTrackingRepository()
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "ProgressTrackingData")
        userDefaultsRepository = UserDefaultsProgressTrackingRepository(userDefaults: userDefaults)
    }
    
    override func tearDown() {
        inMemoryRepository = nil
        userDefaultsRepository = nil
        super.tearDown()
    }
    
    // MARK: - InMemoryProgressTrackingRepository Tests
    
    func testInMemoryFetchTrackingForNewQuestion() {
        let questionId = "question1"
        
        let trackingData = inMemoryRepository.fetchTracking(for: questionId)
        XCTAssertEqual(trackingData.answerState, .none, "Expected default answer state for new question")
    }
    
    func testInMemoryUpdateAndFetchTracking() {
        let questionId = "question1"
        let trackingData = QuestionTrackingData(answerState: .correct)
        
        inMemoryRepository.updateTracking(for: questionId, with: trackingData)
        
        let fetchedData = inMemoryRepository.fetchTracking(for: questionId)
        XCTAssertEqual(fetchedData.answerState, .correct, "Expected updated answer state to be correct")
    }
    
    // MARK: - UserDefaultsProgressTrackingRepository Tests
    
    func testUserDefaultsFetchTrackingForNewQuestion() {
        let questionId = "question2"
        
        let trackingData = userDefaultsRepository.fetchTracking(for: questionId)
        XCTAssertEqual(trackingData.answerState, .none, "Expected default answer state for new question")
    }
    
    func testUserDefaultsUpdateAndFetchTracking() {
        let questionId = "question2"
        let trackingData = QuestionTrackingData(answerState: .incorrect)
        
        userDefaultsRepository.updateTracking(for: questionId, with: trackingData)
        
        let fetchedData = userDefaultsRepository.fetchTracking(for: questionId)
        XCTAssertEqual(fetchedData.answerState, .incorrect, "Expected updated answer state to be wrong")
    }
}
