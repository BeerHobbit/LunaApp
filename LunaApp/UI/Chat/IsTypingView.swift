import SwiftUI

struct IsTypingView: View {
    
    // MARK: - Private Properties
    
    private let isTyping: Bool
    private static let viewOpacity: Double = 0.65
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: AppTheme.Spacings.xSmall) {
            Image(systemName: SystemIcons.ellipsis)
                .symbolEffect(.variableColor.iterative.dimInactiveLayers.nonReversing)
            Text(.isTyping)
                .font(AppFont.regular)
                .foregroundStyle(Color.LunaColors.white)
            Spacer()
        }
        .animation(.easeInOut(duration: AppTheme.Animations.shortDuration)) {
            $0.opacity(isTyping ? IsTypingView.viewOpacity : .zero)
        }
    }
    
    // MARK: - Init
    
    init(isTyping: Bool) {
        self.isTyping = isTyping
    }
    
}
