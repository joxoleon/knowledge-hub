//
//  ContentView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

        var body: some View {
            TabView {
                LessonSectionView(markdownContent: """
                # Introduction to SwiftUI
                SwiftUI is a framework introduced by Apple that allows for declarative UI programming.
                
                - **Declarative**: You describe the UI and its state rather than the steps to modify the UI.
                - **Reactive**: SwiftUI updates the view whenever the state changes.
                
                ```swift
                struct ContentView: View {
                    var body: some View {
                        Text("Hello, World!")
                    }
                }
                ```
                """)
                
                LessonSectionView(markdownContent: """
                ## Full Lesson Content
                This is where the more detailed content of the lesson goes.
                You can use images, code blocks, lists, and more.
                
                ### Example:
                ```swift
                struct ContentView: View {
                    var body: some View {
                        Text("Full Lesson Example")
                    }
                }
                ```
                
                ![SwiftUI Logo](https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96.png)
                """)
                
                LessonSectionView(markdownContent: """
                ### Discussion
                What are the advantages of using SwiftUI?
                
                1. **Declarative**: Write less code to describe the UI.
                2. **Live Previews**: Instant feedback in Xcode.
                """)
                
                LessonSectionView(markdownContent: """
                ### Key Takeaways
                - SwiftUI is declarative and reactive.
                - It integrates with Combine and uses modern Swift features.
                """)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .background(ThemeManager.shared.backgroundColor)
        }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
