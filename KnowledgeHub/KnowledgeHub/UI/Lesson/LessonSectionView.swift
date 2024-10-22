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
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        ScrollView {
            Markdown(markdownContent)
                .markdownTextStyle(\.text) {
                    FontStyle(.normal)
                    ForegroundColor(themeManager.lessonTheme.textColor)
                }
                .markdownTextStyle(\.strong) {
                    FontWeight(.bold)
                    ForegroundColor(themeManager.lessonTheme.textColor)
                }
                .markdownTextStyle(\.emphasis) {
                    FontStyle(.italic)
                    ForegroundColor(themeManager.lessonTheme.textColor)
                }
                .markdownTextStyle(\.code) {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    ForegroundColor(themeManager.lessonTheme.textColor)
                    BackgroundColor(themeManager.lessonTheme.blockquoteBackgroundColor.opacity(0.25))
                }
                .markdownBlockStyle(\.codeBlock) { configuration in
                    codeBlock(configuration)
                }
                .markdownBlockStyle(\.blockquote) { configuration in
                    configuration.label
                        .padding()
                        .background(themeManager.lessonTheme.blockquoteBackgroundColor)
                        .border(themeManager.lessonTheme.blockquoteBorderColor, width: 2)
                        .padding(.top, 10)
                }
                .markdownBlockStyle(\.heading1) { configuration in
                    configuration.label
                        .padding(.bottom, 10)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.4))
                            ForegroundColor(themeManager.lessonTheme.textColor)
                        }
                }
                .markdownBlockStyle(\.heading2) { configuration in
                    configuration.label
                        .padding(.bottom, 8)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.2))
                            ForegroundColor(themeManager.lessonTheme.textColor)
                        }
                }
                .markdownBlockStyle(\.heading3) { configuration in
                    configuration.label
                        .padding(.bottom, 6)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.1))
                            ForegroundColor(themeManager.lessonTheme.textColor)
                        }
                }
                .markdownCodeSyntaxHighlighter(.splash(theme: self.theme))
                .padding()
        }
        .background(themeManager.lessonTheme.backgroundColor)
    }

    @ViewBuilder
    private func codeBlock(_ configuration: CodeBlockConfiguration) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(configuration.language ?? "plain text")
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.semibold)
                    .foregroundColor(themeManager.lessonTheme.textColor)
                Spacer()

                Image(systemName: "clipboard")
                    .onTapGesture {
                        copyToClipboard(configuration.content)
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(themeManager.lessonTheme.blockquoteBackgroundColor)

            Divider()

            ScrollView(.horizontal) {
                highlightCode(configuration.content, language: configuration.language)
                    .padding()
            }
        }
        .background(themeManager.lessonTheme.blockquoteBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .markdownMargin(top: .zero, bottom: .em(0.8))
    }

    private var theme: Splash.Theme {
        .sundellsColors(withFont: .init(size: 13))
    }

    private func copyToClipboard(_ string: String) {
        UIPasteboard.general.string = string
    }

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
            # Markdown Showcase

            **Markdown** is a lightweight markup language that you can use to add formatting elements to plaintext documents. 

            ## Basic Elements

            - **Bold** text
            - *Italic* text
            - ~~Strikethrough~~
            - `Code block inline`
            
            ```swift
            struct ContentView: View {
                var body: some View {
                    Text("This is a code block example in Swift!")
                }
            }
            ```

            > "Blockquotes are useful for highlighting key points or quotes."

            ### Nested List Example
            - Item 1
            - Item 2
              - Sub-item 1
              - Sub-item 2

            *Markdown* is often used for documentation, readme files, and more!
            """
        )
        .environmentObject(ThemeManager(defaultTheme: .midnightBlue))
    }
}
