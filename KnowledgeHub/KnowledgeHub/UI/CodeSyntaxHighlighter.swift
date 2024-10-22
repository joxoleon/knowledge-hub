import SwiftUI
import Splash
import MarkdownUI

// Syntax highlighter implementation using Splash
struct SplashCodeSyntaxHighlighter: CodeSyntaxHighlighter {
    func highlightCode(_ code: String, language: String?) -> Text {
        guard language != nil else {
            return Text(code).font(.system(.body, design: .monospaced))
        }

        // Use Splash's syntax highlighter to highlight the code
        let highlightedCode = self.syntaxHighlighter.highlight(code)

        // Manually extract attributes and construct a SwiftUI Text view
        let attributedString = highlightedCode
        var result = Text("")

        attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length)) { attributes, range, _ in
            let substring = (attributedString.string as NSString).substring(with: range)
            
            // Check if foreground color is set
            if let color = attributes[.foregroundColor] as? UIColor {
                let swiftUIColor = Color(color)
                result = result + Text(substring).foregroundColor(swiftUIColor)
            } else {
                result = result + Text(substring)
            }
        }

        return result
            .font(.system(.body, design: .monospaced))
        
    }
    
    private let syntaxHighlighter: SyntaxHighlighter<AttributedStringOutputFormat>

    init(theme: Splash.Theme) {
        self.syntaxHighlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme))
    }

    func highlightCode(_ content: String, language: String?) -> AttributedText {
        guard language != nil else {
            return AttributedText(attributedString: NSAttributedString(string: content))
        }

        let highlightedCode = self.syntaxHighlighter.highlight(content)
        return AttributedText(attributedString: highlightedCode)
    }
}

extension CodeSyntaxHighlighter where Self == SplashCodeSyntaxHighlighter {
    static func splash(theme: Splash.Theme) -> Self {
        SplashCodeSyntaxHighlighter(theme: theme)
    }
}
