//
//  KHButtonView.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 6.11.24.
//

import SwiftUI

enum KHButtonState {
    case active, disabled
}

struct KHButtonView: View {
    @Binding var state: KHButtonState
    let iconName: String?
    let title: String?
    let iconSize: CGFloat
    let titleFont: Font
    let onSelected: () -> Void

    init(
        state: Binding<KHButtonState>,
        iconName: String? = nil,
        title: String? = nil,
        iconSize: CGFloat = 30,
        titleFont: Font = .subheadline,
        onSelected: @escaping () -> Void
    ) {
        self._state = state
        self.iconName = iconName
        self.title = title
        self.iconSize = iconSize
        self.titleFont = titleFont
        self.onSelected = onSelected
    }

    var body: some View {
        Button(action: {
            onSelected()
        }) {
            VStack(spacing: iconName != nil && title != nil ? 5 : 0) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.system(size: iconSize))
                        .foregroundColor(textColor)
                }
                
                if let title = title {
                    Text(title)
                        .font(titleFont)
                        .fontWeight(.bold)
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    // Base background with gradient
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(buttonBackgroundGradient)

                    // Inner glow effect
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(innerGlowGradient, lineWidth: 4)
                        .blur(radius: 4)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

                    // Gradient border
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderGradient, lineWidth: 2)
                }
            )
        }
        .disabled(state == .disabled)
        .frame(height: 90)
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: state)
    }
}

fileprivate extension KHButtonView {
    // Constants
    var cornerRadius: CGFloat { 15 }

    // Background gradient
    var buttonBackgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.deeperPurple, Color.deepPurple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Inner glow gradient
    var innerGlowGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.white.opacity(0.5), Color.clear]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Border gradient
    var borderGradient: LinearGradient {
        state == .active
        ? LinearGradient(
            gradient: Gradient(colors: [.titleGold, .titleGold.opacity(0.7)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        : LinearGradient(colors: [.placeholderGray, .placeholderGray], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var textColor: Color {
        state == .active ? .titleGold : .gray
    }
}

// MARK: - Preview

struct KHButton_Previews: PreviewProvider {
    @State static var buttonState: KHButtonState = .active

    static var previews: some View {
        ZStack {
            ThemeConstants.verticalGradient
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                KHButtonView(state: $buttonState, iconName: "star", title: "STAR CONTENT", iconSize: 24, titleFont: .system(size: 8)) {
                    print("Button with icon and title tapped!")
                }
                
                KHButtonView(state: $buttonState, iconName: "bolt.circle.fill", title: "FLASH ME", iconSize: 24, titleFont: .subheadline) {
                    print("Button with icon and title tapped!")
                }
                
                KHButtonView(state: .constant(.active), iconName: "bolt.circle.fill", title: nil, iconSize: 50) {
                    print("Button with only icon tapped!")
                }
                
                KHButtonView(state: .constant(.active), iconName: nil, title: "Only Title", titleFont: .title) {
                    print("Button with only title tapped!")
                }
                
                KHButtonView(state: .constant(.disabled), iconName: nil, title: "Disabled Title", titleFont: .subheadline) {
                    print("Disabled button tapped!")
                }
            }
            .padding()
        }
    }
}
