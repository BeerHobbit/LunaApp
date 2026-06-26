import SwiftUI

struct MenuView: View {
    
    // MARK: - Public Propeties
    
    let onDeleteAll: () -> Void
    
    // MARK: - Private Properties
    
    private var buttonSize: CGFloat { AppTheme.Components.buttonSize }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Spacer()
            menuButton(
                image: .delete,
                action: onDeleteAll
            )
        }
        .frame(height: buttonSize)
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private func menuButton(image: ImageResource, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(image)
                .resizable()
                .padding(AppTheme.Spacings.xxSmall)
        }
        .frame(width: buttonSize)
        .tint(Color.LunaColors.white)
    }
    
}
