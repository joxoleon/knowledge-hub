import XCTest
import KHContentSource
@testable import KHBusinessLogic

class KHDomainContentProviderTests: XCTestCase {

    private func instantiateContentProvider() -> KHDomainContentProvider {
        let contentRepository = ContentRepository(fetcher: GitHubContentFetcher(), storage: FileContentStorage())
        let progressTrackingRepository = InMemoryProgressTrackingRepository.placeholder
        return KHDomainContentProvider(contentRepository: contentRepository, progressTrackingRepository: progressTrackingRepository)
    }
    
    func testKHDomainContentProviderUsage() async throws {

        // Arrange
        let contentProvider = instantiateContentProvider()

        // Act
        try await contentProvider.initializeContent()
        
        // Assert
        
        // Modules
        let topLevelModules = contentProvider.getTopLevelModules()
        XCTAssertFalse(topLevelModules.isEmpty)
        let iOSModule = topLevelModules.first!
        print("Top Level Modules: \(iOSModule.debugDescription)")
    }
}
