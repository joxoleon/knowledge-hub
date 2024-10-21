import SwiftUI
import MarkdownUI

struct LessonSectionView: View {
    let markdownContent: String
    
    var body: some View {
        // Scrollable Markdown content with custom styles
        ScrollView {
            Markdown(markdownContent)
                .markdownTextStyle(\.code) {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    ForegroundColor(.purple)
                    BackgroundColor(.purple.opacity(0.25))
                }
                .markdownTextStyle(\.emphasis) {
                    FontStyle(.italic)
                    UnderlineStyle(.single)
                    ForegroundColor(ThemeManager.shared.boldTextColor)
                }
                .markdownTextStyle(\.strong) {
                    FontWeight(.heavy)
                    ForegroundColor(ThemeManager.shared.boldTextColor)
                }
                .markdownTextStyle(\.text) {
                    FontStyle(.normal)
                    ForegroundColor(ThemeManager.shared.textColor)
                }
            // Code block styling
                .markdownBlockStyle(\.codeBlock) { configuration in
                    configuration.label
                        .padding(10)
                        .font(.system(.body, design: .monospaced))
                        .background(Color("background-3"))
                        .cornerRadius(8)
                }
            // Blockquote styling
                .markdownBlockStyle(\.blockquote) { configuration in
                    configuration.label
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .border(Color.blue, width: 2)
                        .padding(.top, 10)
                }
            // Heading 1 styling
                .markdownBlockStyle(\.heading1) { configuration in
                    configuration.label
                        .padding(.bottom, 10)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.4))
                            ForegroundColor(ThemeManager.shared.headingColor)
                        }
                }
            // Heading 2 styling
                .markdownBlockStyle(\.heading2) { configuration in
                    configuration.label
                        .padding(.bottom, 8)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.2))
                            ForegroundColor(ThemeManager.shared.headingColor)
                        }
                }
            // Heading 3 styling
                .markdownBlockStyle(\.heading3) { configuration in
                    configuration.label
                        .padding(.bottom, 6)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.1))
                            ForegroundColor(ThemeManager.shared.headingColor)
                        }
                }
                .padding()
        }
        .background(Color(red: 30/255, green: 34/255, blue: 45/255)) // Custom background
    }
}

// SwiftUI Preview
struct LessonSectionView_Previews: PreviewProvider {
    static var previews: some View {
        LessonSectionView(
            markdownContent: """
            # Introduction to SwiftUI
            `SwiftUI` is a framework introduced by Apple that allows for declarative UI programming.
            
            ## Key Concepts
            - **Declarative**: You describe the UI and its state rather than the steps to modify the UI.
            - **Reactive**: SwiftUI updates the view whenever the state changes.
            
            ```swift
            struct ContentView: View {
                var body: some View {
                    Text("Hello, World!")
                }
            }
            ```
            
            > Something Something
            > In my shoe!
            
            ![SwiftUI Logo](https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96.png)
            """
        )
    }
}
