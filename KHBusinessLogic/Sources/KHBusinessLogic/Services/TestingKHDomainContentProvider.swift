import Foundation
import KHContentSource

public class TestingKHDomainContentProvider: KHDomainContentProviderProtocol {

    // MARK: - Properties

    public let progressTrackingRepository: ProgressTrackingRepository
    public let starTrackingRepository: StarTrackingRepository
    public var activeTopModule: LearningModule {
        topLevelLearningModules.first!
    }

    private var topLevelLearningModules: [LearningModule] = []
    private var lessonsById: [String: Lesson] = [:]

    // MARK: - Initialization

    public init() {
        self.progressTrackingRepository = InMemoryProgressTrackingRepository()
        self.starTrackingRepository = InMemoryStarTrackingRepository()
        initializeMockData()
    }

    // MARK: - KHDomainContentProviderProtocol Methods

    public func initializeContent() async throws {
        // No-op for testing
    }

    public func getLesson(by id: String) -> Lesson? {
        return lessonsById[id]
    }

    public func getTopLevelModules() -> [LearningModule] {
        return topLevelLearningModules
    }

    // MARK: - Private Helper Methods

    private func initializeMockData() {
        let sections = [
            LessonSection(
                content: "# Introduction to SOLID Principles for iOS Development\n\n**SOLID** is an acronym representing five fundamental principles in software development that improve the **modularity**, **scalability**, and **maintainability** of code. These principles help developers create systems that are easy to understand, extend, and modify. By adhering to SOLID principles, iOS developers can structure their code to minimize dependencies, reduce the risk of bugs, and improve testability.\n\nThe five principles that form **SOLID** are:\n- **S**: **Single Responsibility Principle (SRP)**\n- **O**: **Open-Closed Principle (OCP)**\n- **L**: **Liskov Substitution Principle (LSP)**\n- **I**: **Interface Segregation Principle (ISP)**\n- **D**: **Dependency Inversion Principle (DIP)**\n\nEach of these principles can be implemented within iOS applications, using **Swift** language features such as protocols, dependency injection, and modular design patterns to improve software design quality.\n\n> \"Applying SOLID principles enables iOS developers to write cleaner, more robust, and maintainable code that aligns well with modern software engineering standards.\"",
                title: "SOLID Principles Introduction"
            ),
            LessonSection(
                content: "# SOLID Principles Explained\n\n## Single Responsibility Principle (SRP)\n\n### Definition\nA class should have **only one reason to change**, meaning it should have only one job or responsibility.\n\n### iOS Example\nSuppose we have an `ImageUploader` class in an iOS app. If this class handles **image uploading**, **image validation**, and **UI updates**, it violates SRP as it has multiple responsibilities. We can refactor it by:\n- Separating validation into an `ImageValidator` class.\n- Moving UI updates to the controller.\n- Keeping `ImageUploader` focused solely on uploading.\n\n### Code Example\n    class ImageUploader {\n        func upload(_ image: UIImage) { \\/* Upload logic *\\/ }\n    }\n\n    class ImageValidator {\n        func validate(_ image: UIImage) -> Bool { \\/* Validation logic *\\/ }\n    }\n\nWith SRP, each class now has a single, focused responsibility, making testing and maintaining code easier.\n\n---\n\n## Open-Closed Principle (OCP)\n\n### Definition\nSoftware entities should be **open for extension** but **closed for modification**. This principle allows us to add new functionality without altering existing code, minimizing the risk of introducing bugs.\n\n### iOS Example\nImagine a `PaymentProcessor` that needs to support multiple payment methods. By creating a `PaymentMethod` protocol and having each payment method conform to this protocol, we can add new payment methods without changing the `PaymentProcessor` itself.\n\n### Code Example\n    protocol PaymentMethod {\n        func processPayment()\n    }\n\n    class CreditCardPayment: PaymentMethod {\n        func processPayment() { \\/* Credit card payment logic *\\/ }\n    }\n\n    class ApplePayPayment: PaymentMethod {\n        func processPayment() { \\/* Apple Pay payment logic *\\/ }\n    }\n\n    class PaymentProcessor {\n        func process(_ paymentMethod: PaymentMethod) {\n            paymentMethod.processPayment()\n        }\n    }\n\nUsing OCP, adding a new payment method only requires creating a new class that conforms to `PaymentMethod`, without modifying `PaymentProcessor`.\n\n---\n\n## Liskov Substitution Principle (LSP)\n\n### Definition\nObjects of a superclass should be **replaceable with objects of a subclass** without affecting the correctness of the program.\n\n### iOS Example\nConsider a superclass `Vehicle` with a method `drive()`. If we have a subclass `Car` that conforms to `Vehicle`, then `Car` should behave in such a way that replacing `Vehicle` with `Car` does not alter program functionality.\n\n### Code Example\n    class Vehicle {\n        func drive() { \\/* General driving logic *\\/ }\n    }\n\n    class Car: Vehicle {\n        override func drive() { \\/* Car-specific driving logic *\\/ }\n    }\n\nHere, `Car` is a proper subclass of `Vehicle`, following LSP as it can replace `Vehicle` without breaking functionality.\n\n---\n\n## Interface Segregation Principle (ISP)\n\n### Definition\nClients should not be forced to depend on methods they do not use. This principle advocates for creating smaller, **more specific interfaces** rather than a large, monolithic one.\n\n### iOS Example\nConsider an interface for different types of media players. Instead of one large `MediaPlayer` protocol, we create smaller protocols for distinct functionalities like `AudioPlayer` and `VideoPlayer`.\n\n### Code Example\n    protocol AudioPlayer {\n        func playAudio()\n    }\n\n    protocol VideoPlayer {\n        func playVideo()\n    }\n\n    class MusicApp: AudioPlayer {\n        func playAudio() { \\/* Audio playing logic *\\/ }\n    }\n\nIn this example, `MusicApp` conforms only to `AudioPlayer` without needing unnecessary methods, making the code more maintainable and adaptable.\n\n---\n\n## Dependency Inversion Principle (DIP)\n\n### Definition\nHigh-level modules should not depend on low-level modules. Both should depend on abstractions.\n\n### iOS Example\nIn an iOS app, a view controller should not depend directly on a networking service. Instead, it should depend on a protocol, and the networking service should implement that protocol.\n\n### Code Example\n    protocol NetworkService {\n        func fetchData()\n    }\n\n    class APIService: NetworkService {\n        func fetchData() { \\/* Network fetching logic *\\/ }\n    }\n\n    class ViewController {\n        var networkService: NetworkService\n\n        init(networkService: NetworkService) {\n            self.networkService = networkService\n        }\n    }\n\nWith DIP, we can inject a mock service for testing, making the code more modular and testable.",
                title: "SOLID Principles"
            ),
            LessonSection(
                content: "The **SOLID principles** collectively help maintain clean and modular code architecture. However, there can be trade-offs:\n- Over-segmenting interfaces (ISP) may lead to an excessive number of protocols.\n- Following SRP strictly might result in too many classes, which could complicate the codebase.\n- LSP requires careful subclassing to avoid unintended behavior changes.\n\nUltimately, SOLID principles should be applied pragmatically, balancing code clarity with simplicity.",
                title: "Discussion"
            ),
            LessonSection(
                content: "- **SOLID principles** help build **modular, maintainable, and testable** code.\n- **SRP** ensures each class has one responsibility.\n- **OCP** encourages extending, not modifying, existing code.\n- **LSP** ensures subclasses can replace superclasses without issues.\n- **ISP** advocates for small, specific interfaces.\n- **DIP** favors dependency on abstractions, not concrete classes.",
                title: "Key Takeaways"
            )
        ]

        let questions = [
            MultipleChoiceQuestion(
                id: "solid_principles_q1",
                proficiency: .basic,
                question: "What does the Single Responsibility Principle (SRP) state?",
                answers: [
                    "A class should do only one thing.",
                    "A class can have multiple responsibilities.",
                    "A class should be closed for modification.",
                    "A class should implement all methods of an interface."
                ],
                correctAnswerIndex: 0,
                explanation: "SRP specifies that a class should have only one responsibility, which simplifies testing and maintenance.",
                lessonId: "lesson1",
                contentProvider: self
            ),
            MultipleChoiceQuestion(
                id: "solid_principles_q2",
                proficiency: .intermediate,
                question: "Which SOLID principle helps in extending code without modifying it?",
                answers: [
                    "Single Responsibility Principle",
                    "Open-Closed Principle",
                    "Liskov Substitution Principle",
                    "Dependency Inversion Principle"
                ],
                correctAnswerIndex: 1,
                explanation: "OCP allows code to be extended by creating new classes or methods rather than altering existing ones.",
                lessonId: "lesson1",
                contentProvider: self
            ),
            MultipleChoiceQuestion(
                id: "solid_principles_q3",
                proficiency: .advanced,
                question: "Why is the Dependency Inversion Principle important?",
                answers: [
                    "It encourages low-level modules to depend on high-level modules.",
                    "It enables high-level modules to rely on abstractions rather than concrete classes.",
                    "It requires all modules to depend on one main module.",
                    "It discourages modularity."
                ],
                correctAnswerIndex: 1,
                explanation: "DIP enables high-level modules to rely on abstractions, promoting flexible and decoupled code.",
                lessonId: "lesson1",
                contentProvider: self
            ),
            MultipleChoiceQuestion(
                id: "solid_principles_q4",
                proficiency: .intermediate,
                question: "Which principle encourages creating smaller, more specific interfaces?",
                answers: [
                    "Single Responsibility Principle",
                    "Interface Segregation Principle",
                    "Liskov Substitution Principle",
                    "Open-Closed Principle"
                ],
                correctAnswerIndex: 1,
                explanation: "ISP encourages smaller, specific interfaces that prevent clients from being forced to depend on methods they do not use.",
                lessonId: "lesson1",
                contentProvider: self
            ),
            MultipleChoiceQuestion(
                id: "solid_principles_q5",
                proficiency: .basic,
                question: "How does the Liskov Substitution Principle affect subclasses?",
                answers: [
                    "Subclasses can implement only half of a superclass's functionality.",
                    "Subclasses should be able to replace the superclass without altering the program's correctness.",
                    "Subclasses can replace any class in the hierarchy.",
                    "Subclasses should depend on low-level modules."
                ],
                correctAnswerIndex: 1,
                explanation: "LSP ensures that subclasses can replace a superclass without breaking functionality, maintaining program correctness.",
                lessonId: "lesson1",
                contentProvider: self
            )
        ]

        let mockLesson = Lesson(
            id: "solid_principles_for_ios_development",
            title: "SOLID Principles for iOS Development",
            description: "An in-depth lesson on the SOLID principles and their implementation in iOS development to enhance code modularity, maintainability, and scalability.",
            sections: sections,
            questions: questions,
            contentProvider: self
        )

        let mockModule = LearningModule(
            id: "software_design_principles",
            title: "Software Design Principles",
            description: "Explore fundamental principles that guide software architecture design and development.",
            contents: [mockLesson],
            contentProvider: self
        )

        lessonsById[mockLesson.id] = mockLesson
        topLevelLearningModules = [mockModule]
    }
}