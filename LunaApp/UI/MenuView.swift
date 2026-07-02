import SwiftUI

struct MenuView: View {
    
    // MARK: - Public Propeties
    
    let isEmpty: Bool
    let onDeleteAllTap: () -> Void
    let onSettingsTap: () -> Void
    
    // MARK: - Private Properties
    
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
    
    @ViewBuilder
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
    
}
