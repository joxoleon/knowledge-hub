import Foundation
import KHContentSource

public protocol KHDomainContentProviderProtocol {
    var progressTrackingRepository: any ProgressTrackingRepository { get }
    var starTrackingRepository: any StarTrackingRepository { get }
    var activeTopModule: LearningModule { get }

    func initializeContent() async throws    
    func getLesson(by id: String) -> Lesson?
    func getTopLevelModules() -> [LearningModule]
}

public class KHDomainContentProvider: KHDomainContentProviderProtocol {

    // MARK: - Properties

    public let progressTrackingRepository: ProgressTrackingRepository
    public let starTrackingRepository: StarTrackingRepository
    public var activeTopModule: LearningModule {
        topLevelLearningModules.first!
    }

    private let contentRepository: KHContentSource.ContentRepository
    private var topLevelLearningModules: [LearningModule] = []
    private var lessonsById: [String: Lesson] = [:]
    
    // MARK: - Initialization

    public init(contentRepository: ContentRepository, progressTrackingRepository: ProgressTrackingRepository, starTrackingRepository: StarTrackingRepository) {
        self.contentRepository = contentRepository
        self.progressTrackingRepository = progressTrackingRepository
        self.starTrackingRepository = starTrackingRepository
    }

    // MARK: - KHDomainContentProviderProtocol Methods

    public func initializeContent() async throws {
        
        // Initialize content repository and clear local data if it was stale
        let contentRepositoryUpdated = try await contentRepository.updateDataIfNeeded()
        if contentRepositoryUpdated {
            clearAllData()
        }

        // Fetch lessons DTOs from the ContentRepository and transform them to domain models
        let lessonIds = contentRepository.fetchLessonIdCatalog()
        let dtoLessons = contentRepository.fetchLessons(by: lessonIds)
        let domainLessons = dtoLessons.map { Lesson(from: $0, contentProvider: self) }
        domainLessons.forEach { lessonsById[$0.id] = $0 }

        // Fetch modules DTOs from the ContentRepository and transform them to domain models
        let moduleIds = contentRepository.fetchModuleIdCatalog()
        let dtoModules = contentRepository.fetchModules(by: moduleIds)
        let domainModules = dtoModules.map { LearningModule(from: $0, contentProvider: self) }
        topLevelLearningModules = domainModules
    }

    public func getLesson(by id: String) -> Lesson? {
        return lessonsById[id]
    }

    public func getTopLevelModules() -> [LearningModule] {
        return topLevelLearningModules
    }

    // MARK: - Private Helper Methods

    private func clearAllData() {
        lessonsById.removeAll()
        topLevelLearningModules.removeAll()
    }
}
