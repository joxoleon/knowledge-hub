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
            # MVC Architecture

            The **Model-View-Controller (MVC)** design pattern is one of the most widely used software architectural patterns, particularly in iOS development.

            In this lesson, we will cover:
            - The **key components** of MVC
            - How to implement MVC in an iOS application
            - The **benefits** and **drawbacks** of using MVC

            ### Overview
            - **Model**: Responsible for managing the app's data.
            - **View**: The user interface that displays the data.
            - **Controller**: Mediates between the Model and the View.
            """),
            LessonSection(content: """
            # Model-View-Controller Breakdown

            ## The Model
            The **Model** is responsible for:
            - Storing and managing data.
            - Providing data to the controller when requested.

            **Key concept**: The Model does not know anything about the UI or the View.

            Example of a simple `Model` in Swift:
            ```swift
            struct User {
                var name: String
                var age: Int
            }
            ```

            ## The View
            The **View** is responsible for:
            - Displaying the data managed by the Model.
            - Reacting to user input and presenting information.

            **Important**: The View doesn’t manage data, it just displays it.

            ```swift
            struct UserView: View {
                var user: User
                
                var body: some View {
                    VStack {
                        Text("Name: \\(user.name)")
                        Text("Age: \\(user.age)")
                    }
                }
            }
            ```

            ## The Controller
            The **Controller** handles:
            - Managing communication between the Model and the View.
            - Taking user input and updating the Model or View accordingly.

            ```swift
            class UserController {
                var model: User
                
                init(model: User) {
                    self.model = model
                }
                
                func updateUserName(to newName: String) {
                    model.name = newName
                }
            }
            ```

            ## How It Works Together
            The **Controller** updates the **Model**, which then updates the **View**:
            - User interacts with the **View**.
            - The **View** sends the interaction to the **Controller**.
            - The **Controller** updates the **Model**.
            - The **Model** updates the **View** to reflect changes.
            """),
            LessonSection(content: """
            # Discussion

            ## Advantages
            1. **Separation of Concerns**: By separating data (Model), UI (View), and business logic (Controller), your code becomes more modular and maintainable.
            2. **Reusability**: Since the View and Model are independent, they can be reused in different parts of the app.
            3. **Testability**: Each component can be tested independently, making unit testing easier.

            ## Drawbacks
            - **Tight Coupling**: In practice, the View and Controller can become tightly coupled, leading to massive view controllers ("Massive View Controller" problem).
            - **Complexity**: For small apps, MVC can add unnecessary complexity.

            Alternatives like **MVVM (Model-View-ViewModel)** are often considered for better separation in iOS projects.
            """),
            LessonSection(content: """
            # Key Takeaways

            - The **Model** stores and manages data.
            - The **View** displays data to the user.
            - The **Controller** coordinates the flow between the Model and the View.
            - **MVC** helps maintain a clear separation of concerns but can result in large view controllers in practice.

            **Important**: For smaller apps, consider the complexity added by MVC and evaluate if simpler architectures might be better suited.
            """)
        ],
        questions: QuizImpl.placeholderQuiz.questions
    )
}
