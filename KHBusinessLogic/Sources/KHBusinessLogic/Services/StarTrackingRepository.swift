import Foundation

public protocol StarTrackingRepository {
    func isStarred(id: String) -> Bool
    func star(id: String)
    func unstar(id: String)
    func getAllStarred() -> [String]
}

public class InMemoryStarTrackingRepository: StarTrackingRepository {
    private var starredItems: Set<String> = []

    public init() {}

    public func isStarred(id: String) -> Bool {
        return starredItems.contains(id)
    }

    public func star(id: String) {
        starredItems.insert(id)
    }

    public func unstar(id: String) {
        starredItems.remove(id)
    }

    public func getAllStarred() -> [String] {
        return Array(starredItems)
    }
}

public class UserDefaultsStarTrackingRepository: StarTrackingRepository {
    private let userDefaults: UserDefaults
    private let storageKey = "StarTrackingData"

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func isStarred(id: String) -> Bool {
        return userDefaults.array(forKey: storageKey)?.contains(where: { $0 as? String == id }) ?? false
    }

    public func star(id: String) {
        var starredItems = userDefaults.array(forKey: storageKey) as? [String] ?? []
        if !starredItems.contains(id) {
            starredItems.append(id)
            userDefaults.set(starredItems, forKey: storageKey)
        }
    }

    public func unstar(id: String) {
        var starredItems = userDefaults.array(forKey: storageKey) as? [String] ?? []
        if let index = starredItems.firstIndex(of: id) {
            starredItems.remove(at: index)
            userDefaults.set(starredItems, forKey: storageKey)
        }
    }

    public func getAllStarred() -> [String] {
        return userDefaults.array(forKey: storageKey) as? [String] ?? []
    }
}

public extension InMemoryStarTrackingRepository {
    static let placeholder = InMemoryStarTrackingRepository()
}