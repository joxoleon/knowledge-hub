import Testing
@testable import KHBusinessLogic
import KHContentSource

@Test func example() async throws {
    await testContentRepository()
}


private func testContentRepository() async {
    let contentRepository = await initializeContentRepository()
    let modules = contentRepository.fetchAllModuleIds()
    print("Fetched modules: \(modules)")
    let iosModule = contentRepository.fetchModule(by: modules.first!)!
    print("Fetched iOS Preparation module\n: \(iosModule)")
}

private func initializeContentRepository() async -> ContentRepository {
    await withCheckedContinuation { continuation in
        let contentFetcher = GitHubContentFetcher()
        let contentStorage = FileContentStorage()
        let contentRepository = ContentRepository(fetcher: contentFetcher, storage: contentStorage)
        contentRepository.updateDataIfNeeded { updated in
            print("Updated content repository: \(updated)")
            continuation.resume(returning: contentRepository)
        }
    }
}
