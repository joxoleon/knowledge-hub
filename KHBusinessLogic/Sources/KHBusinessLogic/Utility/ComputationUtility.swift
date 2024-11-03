import Foundation

public enum ComputationConsnstants {
    public static let averageReadingSpeed: Double = 150.0
}

public enum ComputationUtility {
    public static func estimateReadTime(for text: String, averageReadingSpeed: Double = ComputationConsnstants.averageReadingSpeed) -> Double {
        let words = text.components(separatedBy: .whitespacesAndNewlines)
        let wordCount = words.count
        let readTime = Double(wordCount) / averageReadingSpeed * 60.0
        return TimeInterval(readTime)
    }
}