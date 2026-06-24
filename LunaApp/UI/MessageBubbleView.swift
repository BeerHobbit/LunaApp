import SwiftUI

struct MessageBubbleView: View {
    
    // MARK: - Public Properties
    
    let message: Message
    
    // MARK: - Private Properties
    
    private let tailSize: CGFloat = AppTheme.Components.tailSize
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: .zero) {
            switch message.sender {
            case .luna:
                lunaMessage
            case .user:
                userMessage
            }
        }
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var lunaMessage: some View {
        Text(message.text)
            .font(AppFont.regular)
            .padding(.vertical, AppTheme.Spacings.medium)
            .padding(.leading, AppTheme.Spacings.medium + tailSize)
            .padding(.trailing, AppTheme.Spacings.medium)
            .background {
                MessageBubbleShape(direction: .left, tailSize: tailSize)
                    .fill(Color.LunaColors.violet)
            }
            .foregroundStyle(Color.LunaColors.white)
        Spacer(minLength: AppTheme.Spacings.messageSpacer)
    }
    
    @ViewBuilder
    private var userMessage: some View {
        Spacer(minLength: AppTheme.Spacings.messageSpacer)
        Text(message.text)
            .font(AppFont.regular)
            .padding(.vertical, AppTheme.Spacings.medium)
            .padding(.leading, AppTheme.Spacings.medium)
            .padding(.trailing, AppTheme.Spacings.medium + tailSize)
            .background {
                MessageBubbleShape(direction: .right)
                    .fill(Color.LunaColors.lightGray)
            }
            .foregroundStyle(Color.LunaColors.black)
    }
    
}
