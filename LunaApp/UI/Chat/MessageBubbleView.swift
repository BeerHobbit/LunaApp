import SwiftUI

struct MessageBubbleView: View {
    
    // MARK: - Public Properties
    
    let message: Message
    let onCopy: (Message) -> Void
    let onDelete: (Message) -> Void
    
    // MARK: - Private Properties
    
    private var tailSize: CGFloat { AppTheme.Components.tailSize }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: .zero) {
            switch message.sender {
            case .luna:
                lunaMessage()
            case .user:
                userMessage()
            }
        }
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private func lunaMessage() -> some View {
        Text(message.text)
            .font(AppFont.regular)
            .padding(.vertical, AppTheme.Spacings.medium)
            .padding(.leading, AppTheme.Spacings.medium + tailSize)
            .padding(.trailing, AppTheme.Spacings.medium)
            .background {
                BubbleShape(direction: .left, tailSize: tailSize)
                    .fill(Color.LunaColors.violet)
            }
            .foregroundStyle(Color.LunaColors.white)
            .contentShape(.contextMenuPreview, Rectangle())
            .contextMenu { menuButtons() }
        Spacer(minLength: AppTheme.Spacings.messageSpacer)
    }
    
    @ViewBuilder
    private func userMessage() -> some View {
        Spacer(minLength: AppTheme.Spacings.messageSpacer)
        Text(message.text)
            .font(AppFont.regular)
            .padding(.vertical, AppTheme.Spacings.medium)
            .padding(.leading, AppTheme.Spacings.medium)
            .padding(.trailing, AppTheme.Spacings.medium + tailSize)
            .background {
                BubbleShape(direction: .right, tailSize: tailSize)
                    .fill(Color.LunaColors.lightGray)
            }
            .foregroundStyle(Color.LunaColors.black)
            .contentShape(.contextMenuPreview, Rectangle())
            .contextMenu { menuButtons() }
    }
    
    @ViewBuilder
    private func menuButtons() -> some View {
        Button(
            .menuCopy,
            systemImage: AppTheme.SystemIcons.copy
        ) { onCopy(message) }
        Button(
            .menuDelete,
            systemImage: AppTheme.SystemIcons.delete,
            role: .destructive
        ) { onDelete(message) }
    }
    
}
