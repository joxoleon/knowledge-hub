//
//  AttributedText.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 21.10.24..
//

import SwiftUI
import MarkdownUI
import Splash
import KHBusinessLogic

struct MarkdownPresentationView: View {
    let markdownString: String
    
    var body: some View {
        ScrollView {
            Markdown(markdownString)
                .markdownTextStyle(\.text) {
                    ForegroundColor(LessonSectionTheme.textColor)
                }
                .markdownTextStyle(\.strong) {
                    FontWeight(.bold)
                    ForegroundColor(LessonSectionTheme.gold1)
                }
                .markdownTextStyle(\.emphasis) {
                    FontStyle(.italic)
                    ForegroundColor(LessonSectionTheme.gold1)
                }
                .markdownTextStyle(\.code) {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    ForegroundColor(LessonSectionTheme.gold1)
                    BackgroundColor(LessonSectionTheme.codeBackground)
                }
                .markdownBlockStyle(\.codeBlock) { configuration in
                    codeBlock(configuration)
                }
                .markdownBlockStyle(\.blockquote) { configuration in
                    configuration.label
                        .padding()
                        .background(LessonSectionTheme.codeBackground)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(LessonSectionTheme.gold1.opacity(0.4), lineWidth: 1)  // Border with rounded corners
                        )
                        .markdownTextStyle {
                            FontWeight(.semibold)
                            FontSize(.em(0.9))
                            ForegroundColor(LessonSectionTheme.gold1)
                        }
                }
                .markdownBlockStyle(\.heading1) { configuration in
                    configuration.label
                        .padding(.bottom, 24)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.4))
                            ForegroundColor(LessonSectionTheme.gold1)
                        }
                }
                .markdownBlockStyle(\.heading2) { configuration in
                    configuration.label
                        .padding(.bottom, 12)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.2))
                            ForegroundColor(LessonSectionTheme.gold1)
                        }
                }
                .markdownBlockStyle(\.heading3) { configuration in
                    configuration.label
                        .padding(.bottom, 6)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.1))
                            ForegroundColor(LessonSectionTheme.gold1)
                        }
                }
                .markdownBlockStyle(\.heading4) { configuration in
                    configuration.label
                        .padding(.bottom, 6)
                        .markdownTextStyle {
                            FontWeight(.bold)
                            FontSize(.em(1.1))
                            ForegroundColor(LessonSectionTheme.gold1)
                        }
                }
                .padding()
        }
    }
    
    
    @ViewBuilder
    private func codeBlock(_ configuration: CodeBlockConfiguration) -> some View {
        VStack(spacing: 0) {
            // Header with language label and copy button
            HStack {
                Text(configuration.language ?? "plain text")
                    .font(.system(.caption, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(LessonSectionTheme.gold1)
                Spacer()
                
                Image(systemName: "clipboard")
                    .onTapGesture {
                        copyToClipboard(configuration.content)
                    }
                    .foregroundColor(LessonSectionTheme.gold1)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(ThemeConstants.cellGradient)
            
            // Divider line
            Divider()
                .background(LessonSectionTheme.gold1.opacity(0.5))
            
            // Scrollable code content
            ScrollView(.horizontal) {
                highlightCode(configuration.content, language: configuration.language)
                    .padding()
            }
            .background(LessonSectionTheme.codeBackground)
        }
        .background(LessonSectionTheme.codeBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 8) // Full rounded rectangle for outer corners
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(LessonSectionTheme.gold1.opacity(0.5), lineWidth: 1)
        )
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

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// SwiftUI Preview
struct LessonSectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ZStack {
            ThemeConstants.verticalGradientDarker
                .ignoresSafeArea()
            
            MarkdownPresentationView(
                markdownString: """
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
            
        }

    }
}
