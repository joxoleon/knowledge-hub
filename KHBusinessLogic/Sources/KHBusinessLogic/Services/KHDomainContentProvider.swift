import Foundation
import KHContentSource

public protocol KHDomainContentProviderProtocol {
    var progressTrackingRepository: any ProgressTrackingRepository { get }
    var starTrackingRepository: any StarTrackingRepository { get }
    var activeTopModule: LearningModule { get }

    func initializeContent() async throws
    func getLesson(by id: String) -> Lesson?
    func getTopLevelModules() -> [LearningModule]

    func searchContent(with query: String, relevanceThreshold: Double) -> [any LearningContent]
    func searchContent(in contents: [LearningContent], with query: String, relevanceThreshold: Double) -> [LearningContent]
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

    public init(
        contentRepository: ContentRepository,
        progressTrackingRepository: ProgressTrackingRepository,
        starTrackingRepository: StarTrackingRepository
    ) {
        self.contentRepository = contentRepository
        self.progressTrackingRepository = progressTrackingRepository
        self.starTrackingRepository = starTrackingRepository
    }

    public init() {
        let fetcher = GitHubContentFetcher()
        let contentStorage = FileContentStorage()
        self.contentRepository = KHContentSource.ContentRepository(
            fetcher: fetcher, storage: contentStorage)
        self.progressTrackingRepository = UserDefaultsProgressTrackingRepository()
        self.starTrackingRepository = UserDefaultsStarTrackingRepository()
    }

    // MARK: - KHDomainContentProviderProtocol Methods

    public func initializeContent() async throws {
        print("*** initialize content invoked *** ")

        // Initialize content repository and clear local data if it was stale
        let contentRepositoryUpdated = try await contentRepository.updateDataIfNeeded()
        if contentRepositoryUpdated {
            clearAllData()
        }

        // Fetch lessons DTOs from the ContentRepository and transform them to domain models
        let lessonIds = contentRepository.fetchLessonIdCatalog()
        let dtoLessons = contentRepository.fetchLessons(by: lessonIds)
        let domainLessons = dtoLessons.map { Lesson(from: $0, contentProvider: self) }
        print("Fetched \(domainLessons.count) lessons")
        domainLessons.forEach { lesson in
            print("Lesson: \(lesson.title)")
            print("Lesson ID: \(lesson.id)")
            self.lessonsById[lesson.id] = lesson
            print("Map contents: \(self.lessonsById[lesson.id]?.title ?? "nil")")
            print("Keys in lessonsById: \(self.lessonsById.keys)")
        }

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

// MARK: - Search

public extension KHDomainContentProviderProtocol {
    func searchContent(
        with query: String,
        relevanceThreshold: Double = 0.2
    ) -> [any LearningContent] {
        let allContents = activeTopModule.learningContents
        return searchContent(in: allContents, with: query, relevanceThreshold: relevanceThreshold)
    }

    func searchContent(
        in contents: [LearningContent],
        with query: String,
        relevanceThreshold: Double = 0.2
    ) -> [LearningContent] {
        return contents
            .map { content in (content, content.relevanceScore(for: query)) }
            .filter { _, score in score >= relevanceThreshold }
            .sorted { $0.1 > $1.1 } // Sort by relevance score descending
            .map { $0.0 } // Return only the contents
    }
}