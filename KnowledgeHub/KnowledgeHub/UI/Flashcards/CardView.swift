import SwiftUI

struct DecorativeCardView: View {
    let text: String

    // Constants scoped to this view
    private struct Constants {
        // Colors
        static let textColor = Color.white
        static let cardFillColor = Color.blue.opacity(0.2)
        static let cardStrokeColor = Color.blue
        static let decorativeBorderColor = Color.blue.opacity(0.7)
        static let gradient = LinearGradient(
            gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.black.opacity(0.7)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        // Border and Decorative Layers
        static let cornerRadius: CGFloat = 15
        static let cardStrokeLineWidth: CGFloat = 2
        static let decorativeBorderWidth: CGFloat = 1
        static let borderOffset: CGFloat = 6 // Distance to offset each decorative layer
        static let borderLayerOffset: CGFloat = 2 // Extra radius for each layer

        // Shadow
        static let shadowColor = Color.black.opacity(0.3)
        static let shadowRadius: CGFloat = 8
        static let shadowOffset: CGFloat = 4
    }

    var body: some View {
        VStack {
            Text(text)
                .font(.largeTitle)
                .foregroundColor(Constants.textColor)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Constants.cardFillColor)
                .background(Constants.gradient.opacity(0.1))
                .overlay(
                    // Main border around the card
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(Constants.cardStrokeColor, lineWidth: Constants.cardStrokeLineWidth)
                )
        )
        .overlay(
            // Decorative borders with offset for layered effect
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius + Constants.borderLayerOffset)
                    .stroke(Constants.decorativeBorderColor, lineWidth: Constants.decorativeBorderWidth)
                    .offset(x: Constants.borderOffset, y: Constants.borderOffset)

                RoundedRectangle(cornerRadius: Constants.cornerRadius + Constants.borderLayerOffset * 2)
                    .stroke(Constants.decorativeBorderColor.opacity(0.8), lineWidth: Constants.decorativeBorderWidth)
                    .offset(x: -Constants.borderOffset, y: -Constants.borderOffset)

                RoundedRectangle(cornerRadius: Constants.cornerRadius + Constants.borderLayerOffset * 3)
                    .stroke(Constants.decorativeBorderColor.opacity(0.6), lineWidth: Constants.decorativeBorderWidth)
                    .offset(x: Constants.borderOffset / 2, y: -Constants.borderOffset / 2)
            }
        )
        .cornerRadius(Constants.cornerRadius)
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius, x: 0, y: Constants.shadowOffset)
        .padding()
    }
}

struct DecorativeCardView_Previews: PreviewProvider {
    static var previews: some View {
        DecorativeCardView(text: "Example Text")
            .frame(width: 200, height: 300)
    }
}
