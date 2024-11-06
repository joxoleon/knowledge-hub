//
//  KHButton.swift
//  KnowledgeHub
//
//  Created by Jovan Radivojsa on 6.11.24..
//

import SwiftUI

enum KHButtonState {
    case active, disabled
}

struct KHButton: View {
    @Binding var state: KHButtonState
    let iconName: String
    let title: String
    let onSelected: () -> Void

    var body: some View {
        Button(action: {
            onSelected()
        }) {
            VStack(spacing: 5) {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(textColor)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15)
                            .fill(buttonBackgroundColor)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 3))
            .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(borderColor, lineWidth: 2))
        }
        .disabled(state == .disabled)
        .frame(height: 90)
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.3), value: state)
    }
}

fileprivate extension KHButton {
    var buttonBackgroundColor: Color {
        return state == .active ? Color.deeperPurple : Color.deeperPurple.opacity(0.6)
    }

    var borderColor: Color {
        return state == .active ? .titleGold : .placeholderGray
    }

    var textColor: Color {
        return state == .active ? .titleGold : .placeholderGray
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
                KHButton(state: $buttonState, iconName: "star", title: "Star Content") {
                    print("Button tapped!")
                }
                KHButton(state: .constant(.disabled), iconName: "clock", title: "Read Time") {
                    print("Disabled button tapped!")
                }
            }
            .padding()
        }

    }
}
