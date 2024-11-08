import SwiftUI

struct FlashCardView: View {
    @State public var cards: [String] = ["Card 1", "Card2", "Card3" , "Card4"]
    @Binding public var isPresented: Bool

    @State private var discardedCards: [String] = []
    @State private var dragOffset: CGSize = .zero

    // Constants
    private struct Constants {
        // Colors and Gradient
        static let backgroundColor = Color.black.opacity(0.7)
        static let gradient = RadialGradient(
            gradient: Gradient(colors: [Color.violet, Color.black]),
            center: .center,
            startRadius: 100,
            endRadius: 650
        )
        static let cardFillColor = Color.black.opacity(0.6)
        static let cardStrokeColor = Color.titleGold.opacity(0.8)
        static let overlayStrokeColor = Color.purple.opacity(0.2)
        static let textColor = Color.white

        // Opacities and sizes
        static let cardScale: CGFloat = 0.95
        static let cardOpacity: Double = 1.0
        static let cornerRadius: CGFloat = 20
        static let strokeLineWidth: CGFloat = 1
        static let cardStrokeLineWidth: CGFloat = 2
        static let dragRotationDivider: Double = 20

        // Animation settings
        static let swipeThreshold: CGFloat = 141 // Swipe distance to trigger removal
        static let offScreenOffset: CGFloat = 1000 // Offset to move the card off-screen
    }

    var body: some View {
        ZStack {
            Constants.backgroundColor
                .edgesIgnoringSafeArea(.all)
                .overlay(Constants.gradient)

            if !cards.isEmpty {
                // Render all background cards without interaction
                ForEach(cards.dropLast(), id: \.self) { card in
                    if !discardedCards.contains(card) {
                        cardView(for: card)
                            .scaleEffect(Constants.cardScale)
                            .opacity(Constants.cardOpacity)
                            .zIndex(Double(cards.firstIndex(of: card) ?? 0))
                            .animation(.default, value: discardedCards)
                    }
                }

                // Render top card with swipe interaction
                if let topCard = cards.last, !discardedCards.contains(topCard) {
                    cardView(for: topCard)
                        .offset(dragOffset)
                        .rotationEffect(.degrees(Double(dragOffset.width / Constants.dragRotationDivider)))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation
                                }
                                .onEnded { value in
                                    if abs(value.translation.width) > Constants.swipeThreshold {
                                        // Determine off-screen direction and animate card off-screen
                                        let swipeDirection = value.translation.width > 0 ? Constants.offScreenOffset : -Constants.offScreenOffset
                                        
                                        withAnimation(.easeOut(duration: 0.5)) {
                                            dragOffset = CGSize(width: swipeDirection, height: 0)
                                        }
                                        
                                        // Move card to discarded list after animation completes
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            discardTopCard()
                                            dragOffset = .zero // Reset offset for next card

                                            // Check if no more cards remain, then dismiss the view
                                            if cards.isEmpty {
                                                isPresented = false
                                            }
                                        }
                                    } else {
                                        // Snap back if swipe is not far enough
                                        withAnimation(.spring()) {
                                            dragOffset = .zero
                                        }
                                    }
                                }
                        )
                        .zIndex(Double(cards.count))
                }
            }
        }
    }

    private func cardView(for text: String) -> some View {
        ZStack {
            
            // Main card content
            VStack {
                MarkdownPresentationView(markdownString: text)
                    .padding(.vertical, 50)
                    .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(ThemeConstants.verticalGradient3)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(Constants.cardStrokeColor, lineWidth: Constants.cardStrokeLineWidth)
                            .shadow(color: Color.titleGold.opacity(0.6), radius: 6, x: 0, y: 0)
                    )
            )
            .padding()
            
            // Rhomboid elements exactly in the corners
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                let frameSize: CGFloat = 10
                let offset: CGFloat = 35
                let rhomboidOffset: CGFloat = 8  // Half of rhomboid width/height to center it at the corner
                
                Group {
                    // Top-left corner
                    Rhomboid()
                        .fill(Color.titleGold)
                        .frame(width: frameSize, height: frameSize)
                        .position(x: offset + rhomboidOffset, y: offset + rhomboidOffset)
                        .shadow(color: Color.titleGold.opacity(0.6), radius: 6, x: 0, y: 0)

                    
                    // Top-right corner
                    Rhomboid()
                        .fill(Color.titleGold)
                        .frame(width: frameSize, height: frameSize)
                        .position(x: width - offset - rhomboidOffset, y: offset + rhomboidOffset)
                        .shadow(color: Color.titleGold.opacity(0.6), radius: 6, x: 0, y: 0)

                    
                    // Bottom-left corner
                    Rhomboid()
                        .fill(Color.titleGold)
                        .frame(width: frameSize, height: frameSize)
                        .position(x: offset + rhomboidOffset, y: height - offset - rhomboidOffset)
                        .shadow(color: Color.titleGold.opacity(0.6), radius: 6, x: 0, y: 0)

                    
                    // Bottom-right corner
                    Rhomboid()
                        .fill(Color.titleGold)
                        .frame(width: frameSize, height: frameSize)
                        .position(x: width - offset - rhomboidOffset, y: height - offset - rhomboidOffset)
                        .shadow(color: Color.titleGold.opacity(0.6), radius: 6, x: 0, y: 0)

                }
            }
        }
    }


    private func discardTopCard() {
        if let topCard = cards.last {
            // Move the card to discardedCards to fully discard it from the stack
            discardedCards.append(topCard)
            cards.removeLast()
        }
    }
}

// Custom rhomboid shape
struct Rhomboid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

struct FlashCardView_Previews: PreviewProvider {
    @State static var isPresented = true

    static var previews: some View {
        FlashCardView(isPresented: $isPresented)
    }
}
