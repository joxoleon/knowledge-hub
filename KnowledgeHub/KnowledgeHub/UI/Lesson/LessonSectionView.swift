import SwiftUI
import MarkdownUI

struct LessonSectionView: View {
    let markdownContent: String
    
    var body: some View {
        // Scrollable Markdown content with custom styles
        ScrollView {
            Markdown(markdownContent)
//                .markdownTextStyle(\.heading1) {
//                    FontFamily(.custom("Helvetica-Bold"))
//                    FontSize(32)
//                    ForegroundColor(.blue)
//                }
//                .markdownTextStyle(\.heading2) {
//                    FontFamily(.custom("Helvetica"))
//                    FontSize(24)
//                    ForegroundColor(.gray)
//                }
//                .markdownTextStyle(\.paragraph) {
//                    FontFamily(.custom("Helvetica"))
//                    FontSize(18)
//                    ForegroundColor(.primary)
//                }
                .markdownTextStyle(\.code) {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    ForegroundColor(.purple)
                    BackgroundColor(.purple.opacity(0.25))
                }
                .markdownTextStyle(\.strong) {
                    FontWeight(.bold)
                    FontSize(20)
                }
                .markdownBlockStyle(\.codeBlock) { label in
                    ScrollView(.horizontal) {
                        label
                            .padding()
                    }
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
        }
        .background(Color(red: 30/255, green: 34/255, blue: 45/255)) // Custom background
//        .ignoresSafeArea()
    }
}

// SwiftUI Preview
struct LessonSectionView_Previews: PreviewProvider {
    static var previews: some View {
        LessonSectionView(
            markdownContent: """
            # Introduction to SwiftUI
            SwiftUI is a framework introduced by Apple that allows for declarative UI programming.
            
            ## Key Concepts
            - **Declarative**: You describe the UI and its state rather than the steps to modify the UI.
            - **Reactive**: SwiftUI updates the view whenever the state changes.
            
            ```
            struct ContentView: View {
                var body: some View {
                    Text("Hello, World!")
                }
            }
            ```
            
            ![SwiftUI Logo](https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96.png)
            """
        )
    }
}
