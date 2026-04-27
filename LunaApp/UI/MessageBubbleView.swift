import SwiftUI

struct MessageBubbleView: View {
    
    // MARK: - Public Properties
    
    let message: Message
    let availableWidth: CGFloat
    
    // MARK: - Constants
    
    private enum Constants {
        static let tailSize: CGFloat = 9
        static let maxWidthMod: Double = 0.8
        
        static let topInset: CGFloat = 8
        static let leadingInset: CGFloat = 12
        static let bottomInset: CGFloat = 12
        static let trailingInset: CGFloat = 12
        
        static let shadowOpacity: Double = 0.35
        static let shadowRadius: CGFloat = 0
        static let shadowXOffset: CGFloat = -4
        static let shadowYOffset: CGFloat = -4
    }
    
    // MARK: - Private Properties
    
    private var sender: Sender {
        message.sender
    }
    
    private var messagePadding: EdgeInsets {
        EdgeInsets(
            top: Constants.topInset,
            leading: Constants.leadingInset + (bubbleDirection == .left ? Constants.tailSize : 0),
            bottom: Constants.bottomInset,
            trailing: Constants.trailingInset + (bubbleDirection == .right ? Constants.tailSize : 0)
        )
    }
    
    private var bubbleColor: Color {
        switch sender {
        case .luna: .LunaColors.violet
        case .user: .LunaColors.white
        }
    }
    
    private var textColor: Color {
        switch sender {
        case .luna: .LunaColors.white
        case .user: .LunaColors.black
        }
    }
    
    private var bubbleDirection: MessageBubbleShape.Direction {
        switch sender {
        case .luna: .left
        case .user: .right
        }
    }
    
    private var bubbleStyle: some ShapeStyle {
        bubbleColor
            .shadow(
                .inner(
                    color: .LunaColors.black.opacity(Constants.shadowOpacity),
                    radius: Constants.shadowRadius,
                    x: Constants.shadowXOffset,
                    y: Constants.shadowYOffset
                )
            )
    }
    
    private var maxWidth: CGFloat {
        availableWidth * Constants.maxWidthMod
    }
    
    private var alignment: Alignment {
        switch sender {
        case .luna: .leading
        case .user: .trailing
        }
    }
    
    private var transitionEdge: Edge {
        switch sender {
        case .luna: .leading
        case .user: .trailing
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if bubbleDirection != .left {
                Spacer()
            }
            Text(message.text)
                .font(AppFont.regular)
                .padding(messagePadding)
                .background {
                    MessageBubbleShape(
                        direction: bubbleDirection,
                        tailSize: Constants.tailSize
                    )
                    .fill(bubbleStyle)
                }
                .foregroundStyle(textColor)
                .frame(maxWidth: maxWidth, alignment: alignment)
            if bubbleDirection != .right {
                Spacer()
            }
        }
        .transition(.move(edge: transitionEdge).combined(with: .opacity))
    }
    
}

#Preview {
    MessageBubbleView(
        message: Message(
            id: UUID(),
            text: "Привет, Луна! Расскажи, как у тебя дела?",
            sender: .user
        ),
        availableWidth: 350
    )
}

#Preview {
    MessageBubbleView(
        message: Message(
            id: UUID(),
            text: "Привет! Разработчик еще не добавил мне интеллект, но он работает над этим.",
            sender: .luna
        ),
        availableWidth: 350
    )
}
