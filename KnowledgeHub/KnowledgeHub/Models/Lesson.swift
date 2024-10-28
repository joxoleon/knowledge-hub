//
//  Lesson.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 23.10.24..
//

import Foundation

class Lesson: Identifiable, LearningContent {
    let id: LearningContentId
    let title: String
    let description: String?
    let sections: [LessonSection]
    let questions: [Question]
    
    // MARK: - Learning Content Computed Properties
    
    lazy var quiz: Quiz = {
        QuizImpl(
            id: self.id.toQuizId(),
            questions: self.questions,
            progressTrackingRepository: self.quiz.progressTrackingRepository
        )
    }()
    
    // MARK: - Initialization
    
    init(
        id: LearningContentId,
        title: String,
        description: String? = nil,
        sections: [LessonSection],
        questions: [Question]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.sections = sections
        self.questions = questions
    }
}

struct LessonSection: Identifiable {
    let id: UUID = UUID()
    let content: String // In Markdown
}

// MARK: - Placeholder


extension Lesson {
    static let placeholder = Lesson(
        id: LearningContentId("placeholderLessonId"),
        title: "MVC Architecture",
        description: "Breakdown of the MVC architecture",
        sections: [
            LessonSection(content: """
            # Protocols in Swift
            A **Protocol** is a blueprint that defines methods, properties, and requirements that a class, struct, or enum must adopt to conform to a particular behavior. Protocols are integral to Swift's type system, enabling flexible, modular, and reusable code. In **iOS development**, protocols are heavily used in delegation, data sources, and creating adaptable, testable components. They encourage *loose coupling*, making code easier to manage and extend.

            """),
            LessonSection(content: """
            # Protocols

            ### What is a Protocol?

            In Swift, a protocol declares requirements for *behavior* or *properties* that a conforming type must implement. Unlike classes or structs, protocols do not include any implementation details but rather act as *contracts* that a type must fulfill, promoting modular code and design.

            #### Declaring a Protocol

            To declare a protocol, use the `protocol` keyword, followed by a name and requirements for any conforming types. Here's an example:

                protocol Drivable {
                    var speed: Int { get set }
                    func drive()
                }

            In the example above, the `Drivable` protocol specifies that any conforming type must implement a `speed` property and a `drive()` method.

            #### Conforming to a Protocol

            A type conforms to a protocol by implementing the required properties and methods, adding the protocol name after the type’s name. For instance:

                struct Car: Drivable {
                    var speed: Int
                    func drive() {
                        print("The car is driving at \\(speed) km/h.")
                    }
                }

            In this example, the `Car` struct conforms to the `Drivable` protocol by providing its own implementations of `speed` and `drive()`.

            #### Protocols with Classes and Structs

            Protocols allow polymorphism by enabling different types to be treated the same way if they conform to the same protocol. Here’s another example with two classes:

                protocol SoundPlayable {
                    func playSound()
                }

                class Bird: SoundPlayable {
                    func playSound() {
                        print("Tweet tweet!")
                    }
                }

                class Dog: SoundPlayable {
                    func playSound() {
                        print("Woof woof!")
                    }
                }

            Both `Bird` and `Dog` conform to the `SoundPlayable` protocol, so they can both be treated as `SoundPlayable` types, allowing for adaptable code.

            #### Protocols and Delegation

            **Delegation** is a popular design pattern that enables one object to perform tasks on behalf of another. In iOS, protocols are essential for implementing delegation, often for tasks like managing data in a table view.

                protocol TableViewDelegate {
                    func didSelectRow(at index: Int)
                }

                class TableView {
                    var delegate: TableViewDelegate?

                    func selectRow(at index: Int) {
                        delegate?.didSelectRow(at: index)
                    }
                }

                class ViewController: TableViewDelegate {
                    func didSelectRow(at index: Int) {
                        print("Row \\(index) was selected.")
                    }
                }

            Here, `TableView` uses a delegate of type `TableViewDelegate` to notify `ViewController` when a row is selected. This makes `TableView` flexible and modular, as any class conforming to `TableViewDelegate` can act as the delegate.

            #### Protocol Composition

            Swift allows a type to conform to multiple protocols, which is known as **protocol composition**. Protocol composition can be helpful when defining a type requirement by combining multiple protocols.

                protocol Flyable {
                    func fly()
                }

                protocol Drivable {
                    var speed: Int { get set }
                    func drive()
                }

                struct FlyingCar: Flyable, Drivable {
                    var speed: Int

                    func fly() {
                        print("Flying at speed \\(speed)")
                    }

                    func drive() {
                        print("Driving at speed \\(speed)")
                    }
                }

            In this example, `FlyingCar` conforms to both `Flyable` and `Drivable`, showing how a single type can fulfill multiple roles.

            """),
            LessonSection(content: """
            # Discussion

            #### Pros of Using Protocols

            - **Modularity**: Protocols allow for modular, reusable code, reducing dependency on specific implementations.
            - **Loose Coupling**: Protocols promote *loose coupling*, which enhances flexibility and testability by allowing code to interact via abstractions rather than concrete types.
            - **Adaptability**: Protocols are critical in implementing iOS patterns like *delegation* and *dependency injection*, which allow code to be more adaptable.

            #### Cons of Using Protocols

            - **Complexity**: Overusing protocols can add complexity, as managing multiple conformances can become challenging.
            - **Performance**: Using protocols can introduce a slight performance overhead due to dynamic dispatch, particularly in complex protocol-oriented code.
            - **Learning Curve**: Swift’s protocol-oriented approach can be unfamiliar to new developers, requiring a learning curve to use effectively.

            #### Common Use Cases

            - **Delegation**: Frequently used in iOS for managing UI events, such as handling row selection in table views.
            - **Decoupling Dependencies**: Protocols enable dependency injection by allowing objects to rely on abstractions, not concrete implementations.
            - **Testing**: Protocols make unit testing easier by allowing mock objects to be substituted for actual dependencies.

            """),
            LessonSection(content: """
            # Key Takeaways

            - Protocols in Swift define a *contract* for behavior and properties that conforming types must fulfill.
            - Protocols encourage modularity, flexibility, and testability in iOS development.
            - Protocol-oriented programming allows for more adaptable and reusable code in Swift.
            - Protocols are widely used in iOS for *delegation*, *dependency injection*, and *interface abstraction*.

            """)
        ],
        questions: QuizImpl.placeholderQuiz.questions
    )
}
