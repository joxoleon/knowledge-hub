////
////  LearningContentRepository.swift
////  KnowledgeHub
////
////  Created by Jovan Radivojsa on 27.10.24..
////
//
//import Foundation
//
//protocol LearningContentRepository {
//    func fetchLearningModule(by id: LearningContentId) -> LearningModule?
//    func fetchLesson(by id: LearningContentId) -> Lesson?
//}
//
//class PlaceholderLearningContentRepository: LearningContentRepository {
//    
//    private var modules: [LearningContentId: LearningModule] = [:]
//    private var lessons: [LearningContentId: Lesson] = [:]
//    
//    init(progressTrackingRepository: ProgressTrackingRepository) {
//            // Hardcoded Lessons
//            let lesson1 = Lesson(
//                id: LearningContentId("lesson1"),
//                title: "Dependency Injection Basics",
//                description: "A basic introduction to Dependency Injection",
//                sections: [
//                    LessonSection(content: """
//                        Dependency Injection is a software design pattern that enables loose coupling in code by injecting dependencies into a class, rather than hardcoding them.
//                        """)
//                ],
//                quiz: QuizImpl(
//                    id: LearningContentId("lesson1").toQuizId(),
//                    questions: [
//                        MultipleChoiceQuestion(
//                            id: QuestionId("question1"),
//                            profficiency: .basic,
//                            question: "What is Dependency Injection?",
//                            answers: ["A design pattern", "A debugging tool"],
//                            correctAnswerIndex: 0,
//                            explanation: "Dependency Injection is a design pattern to decouple components.",
//                            progressTrackingRepository: progressTrackingRepository
//                        )
//                    ],
//                    progressTrackingRepository: progressTrackingRepository
//                )
//            )
//            
//            let lesson2 = Lesson(
//                id: LearningContentId("lesson2"),
//                title: "Advanced Dependency Injection",
//                description: "Deeper dive into Dependency Injection techniques and best practices.",
//                sections: [
//                    LessonSection(content: """
//                        This lesson discusses advanced Dependency Injection techniques such as property injection and initializer injection.
//                        """)
//                ],
//                quiz: QuizImpl(
//                    id: LearningContentId("lesson2").toQuizId(),
//                    questions: [
//                        MultipleChoiceQuestion(
//                            id: QuestionId("question2"),
//                            profficiency: .intermediate,
//                            question: "Which of the following is a benefit of Dependency Injection?",
//                            answers: ["Tighter coupling", "Increased testability"],
//                            correctAnswerIndex: 1,
//                            explanation: "Dependency Injection allows for more testable code.",
//                            progressTrackingRepository: progressTrackingRepository
//                        )
//                    ],
//                    progressTrackingRepository: progressTrackingRepository
//                )
//            )
//            
//            // Hardcoded Learning Modules
//            let module1 = LearningModule(
//                id: LearningContentId("module1"),
//                title: "Swift Programming Basics",
//                description: "Introduction to fundamental Swift programming concepts.",
//                contents: [lesson1, lesson2],
//                progressTrackingRepository: progressTrackingRepository
//            )
//            
//            // Store modules and lessons in dictionaries for quick access
//            modules[module1.id] = module1
//            lessons[lesson1.id] = lesson1
//            lessons[lesson2.id] = lesson2
//        }
//    
//    func fetchLearningModule(by id: LearningContentId) -> LearningModule? {
//        modules[id]
//    }
//    
//    func fetchLesson(by id: LearningContentId) -> Lesson? {
//        lessons[id]
//    }
//}
