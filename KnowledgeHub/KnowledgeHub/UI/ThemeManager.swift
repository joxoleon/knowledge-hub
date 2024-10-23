import SwiftUI


public class ColorManager: ObservableObject {
    
    @Published var theme: ColorTheme

    init(colorTheme: ColorTheme) {
        self.theme = colorTheme
    }
    
    func switchTheme(to theme: ColorTheme) {
        self.theme = theme
    }
}

// MARK: - Themes

public struct ColorTheme {
    // Background Colors
    var backgroundColor: Color
    var backgroundLighterColor: Color
    var blockquoteBackgroundColor: Color
    var codeBackgroundColor: Color
    // Text Colors
    var textColor: Color
    var strongTextColor: Color
    var emphasisTextColor: Color
    var headingTextColor: Color
    var quoteTextColor: Color
    var inlineCodeTextColor: Color
    // Border Colors
    var blockquoteBorderColor: Color
}

extension ColorTheme {
    public static let midnightBlue = ColorTheme(
        // Background Colors
        backgroundColor: Color(#colorLiteral(red: 0.098, green: 0.145, blue: 0.203, alpha: 1)),
        backgroundLighterColor: Color(#colorLiteral(red: 0.1, green: 0.2, blue: 0.341, alpha: 1)),
        blockquoteBackgroundColor: Color(#colorLiteral(red: 0.145, green: 0.192, blue: 0.247, alpha: 1)),
        codeBackgroundColor: Color(#colorLiteral(red: 0.08627839598, green: 0.1753570129, blue: 0.247, alpha: 1)),
        // Text Colors
        textColor: Color(#colorLiteral(red: 0.839, green: 0.851, blue: 0.882, alpha: 1)),
        strongTextColor: Color(#colorLiteral(red: 0.9461077131, green: 0.8667619021, blue: 0.6855118213, alpha: 1)),
        emphasisTextColor: Color(#colorLiteral(red: 0.9461077131, green: 0.8667619021, blue: 0.6855118213, alpha: 1)),
        headingTextColor: Color(#colorLiteral(red: 0.8470588235, green: 0.6039215686, blue: 0.337254902, alpha: 1)),
        quoteTextColor: Color(#colorLiteral(red: 0.9461077131, green: 0.8667619021, blue: 0.6855118213, alpha: 1)),
        inlineCodeTextColor: Color(#colorLiteral(red: 0.9461077131, green: 0.8667619021, blue: 0.6855118213, alpha: 1)),
        // Border Colors
        blockquoteBorderColor: Color(#colorLiteral(red: 0.298, green: 0.537, blue: 0.882, alpha: 1))
    )
}

