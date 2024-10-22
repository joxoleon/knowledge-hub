//
//  AttributedText.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import MarkdownUI
import Splash

struct LessonSectionView: View {
    let markdownContent: String
    @Environment(\.colorScheme) private var colorScheme

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
            // Code block styling with syntax highlighting
                .markdownBlockStyle(\.codeBlock) { configuration in
                    codeBlock(configuration)
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
                .markdownCodeSyntaxHighlighter(.splash(theme: self.theme)) // Apply syntax highlighting
                .padding()
        }
        .background(Color(red: 30/255, green: 34/255, blue: 45/255)) // Custom background
    }

    // Custom code block view for syntax highlighting
    @ViewBuilder
    private func codeBlock(_ configuration: CodeBlockConfiguration) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(configuration.language ?? "plain text")
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(theme.plainTextColor))
                Spacer()

                Image(systemName: "clipboard")
                    .onTapGesture {
                        copyToClipboard(configuration.content)
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                Color(theme.backgroundColor)
            }

            Divider()

            ScrollView(.horizontal) {
                highlightCode(configuration.content, language: configuration.language)
                    .padding()
            }
        }
        .background(Color(ThemeManager.shared.codeBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .markdownMargin(top: .zero, bottom: .em(0.8))
    }

    private var theme: Splash.Theme {
        .sundellsColors(withFont: .init(size: 13))
    }

    private func copyToClipboard(_ string: String) {
        UIPasteboard.general.string = string
    }

    // Helper to highlight code
    private func highlightCode(_ content: String, language: String?) -> AttributedText {
        let highlighter = SplashCodeSyntaxHighlighter(theme: theme)
        return highlighter.highlightCode(content, language: language)
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
