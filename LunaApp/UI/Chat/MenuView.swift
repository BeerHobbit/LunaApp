import SwiftUI

struct MenuView: View {
    
    // MARK: - Private Properties
    
    private let isEmpty: Bool
    private let onDeleteAllTap: () -> Void
    private let onSettingsTap: () -> Void
    private var buttonSize: CGFloat { AppTheme.Components.buttonSize }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            menuButton(
                image: .settings,
                action: onSettingsTap
            )
            Spacer()
            menuButton(
                image: .delete,
                action: onDeleteAllTap
            )
            .disabled(isEmpty)
        }
    }
    
    // MARK: - Views
    
    private func menuButton(image: ImageResource, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(AppTheme.Spacings.xxSmall)
        }
        .frame(width: buttonSize, height: buttonSize)
        .tint(Color.LunaColors.white)
    }
    
    // MARK: - Init
    
    init(
        isEmpty: Bool,
        onDeleteAllTap: @escaping () -> Void,
        onSettingsTap: @escaping () -> Void
    ) {
        self.isEmpty = isEmpty
        self.onDeleteAllTap = onDeleteAllTap
        self.onSettingsTap = onSettingsTap
    }
    
}
