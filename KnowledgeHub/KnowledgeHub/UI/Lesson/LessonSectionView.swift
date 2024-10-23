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
    let section: LessonSection
    @EnvironmentObject var themeManager: ColorManager
    
    var body: some View {
        ScrollView {
            Markdown(section.content)
                .markdownTextStyle(\.text) {
                    ForegroundColor(themeManager.theme.textColor)
                }
                .markdownTextStyle(\.strong) {
                    FontWeight(.bold)
                    ForegroundColor(themeManager.theme.strongTextColor)
                }
                .markdownTextStyle(\.emphasis) {
                    FontStyle(.italic)
                    ForegroundColor(themeManager.theme.emphasisTextColor)
                }
                .markdownTextStyle(\.code) {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    ForegroundColor(themeManager.theme.inlineCodeTextColor)
                    BackgroundColor(themeManager.theme.codeBlockInlineBackgroundColor)
                }
                .markdownBlockStyle(\.codeBlock) { configuration in
                    codeBlock(configuration)
                }
                .markdownBlockStyle(\.blockquote) { configuration in
                    configuration.label
                        .padding()
                        .background(themeManager.theme.blockquoteBackgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(themeManager.theme.blockquoteBorderColor, lineWidth: 2)  // Border with rounded corners
                        )
                        .markdownTextStyle {
                            FontWeight(.semibold)
                            FontSize(.em(0.9))
                            ForegroundColor(themeManager.theme.quoteTextColor)
                        }
                }
                .markdownBlockStyle(\.heading1) { configuration in
                    configuration.label
                        .padding(.bottom, 24)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.4))
                            ForegroundColor(themeManager.theme.heading1TextColor)
                        }
                }
                .markdownBlockStyle(\.heading2) { configuration in
                    configuration.label
                        .padding(.bottom, 12)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.2))
                            ForegroundColor(themeManager.theme.heading2TextColor)
                        }
                }
                .markdownBlockStyle(\.heading3) { configuration in
                    configuration.label
                        .padding(.bottom, 6)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.1))
                            ForegroundColor(themeManager.theme.heading3TextColor)
                        }
                }
                .padding()
        }
        .background(themeManager.theme.backgroundColor)
        .frame(maxWidth: .infinity)
    }
    
    
    @ViewBuilder
    private func codeBlock(_ configuration: CodeBlockConfiguration) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(configuration.language ?? "plain text")
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.theme.codeBlockLanguageTextColor)
                Spacer()
                
                Image(systemName: "clipboard")
                    .onTapGesture {
                        copyToClipboard(configuration.content)
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(themeManager.theme.backgroundLighterColor)
            
            Divider()
            
            ScrollView(.horizontal) {
                highlightCode(configuration.content, language: configuration.language)
                    .padding()
            }
        }
        .background(themeManager.theme.blockquoteBackgroundColor)
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
            section: LessonSection(content:"""
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
        )
        .environmentObject(ColorManager(colorTheme: .midnightBlue))
    }
}
