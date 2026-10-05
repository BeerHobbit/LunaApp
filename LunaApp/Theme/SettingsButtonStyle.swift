import SwiftUI

struct SettingsButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    private static let opacity: Double = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: AppTheme.Components.buttonSize)
            .font(AppFont.medium)
            .background(Color.LunaColors.white)
            .foregroundStyle(Color.LunaColors.black)
            .clipShape(.rect)
            .opacity(configuration.isPressed || !isEnabled ? Self.opacity : 1.0)
    }
}
