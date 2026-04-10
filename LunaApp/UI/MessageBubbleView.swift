import SwiftUI

struct MessageBubbleView: View {
    
    let message: Message
    let availableWidth: CGFloat
    let maxWidthMod: Double = 0.8
    
    var body: some View {
        switch message.sender {
        case .user:
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(message.text)
                    .font(AppFont.regular)
                    .padding(
                        EdgeInsets(
                            top: 8,
                            leading: 14,
                            bottom: 14,
                            trailing: 14
                        )
                    )
                    .background(
                        Color.LunaColors.white
                            .shadow(
                                .inner(
                                    color: .black.opacity(0.35),
                                    radius: 0,
                                    x: -4,
                                    y: -4
                                )
                            )
                    )
                    .foregroundStyle(Color.LunaColors.black)
                    .frame(maxWidth: availableWidth * maxWidthMod, alignment: .trailing)
            }
            .transition(.move(edge: .trailing).combined(with: .opacity))
        case .luna:
            HStack(alignment: .center, spacing: 0) {
                Text(message.text)
                    .font(AppFont.regular)
                    .padding(
                        EdgeInsets(
                            top: 8,
                            leading: 14,
                            bottom: 14,
                            trailing: 14
                        )
                    )
                    .background(
                        Color.LunaColors.violet
                            .shadow(
                                .inner(
                                    color: .black.opacity(0.35),
                                    radius: 0,
                                    x: -4,
                                    y: -4
                                )
                            )
                    )
                    .foregroundStyle(Color.LunaColors.white)
                    .frame(maxWidth: availableWidth * maxWidthMod, alignment: .leading)
                Spacer(minLength: 0)
            }
            .transition(.move(edge: .leading).combined(with: .opacity))
        }
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
