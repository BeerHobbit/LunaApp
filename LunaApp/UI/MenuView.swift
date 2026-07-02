import SwiftUI

struct MenuView: View {
    
    // MARK: - Public Propeties
    
    let isEmpty: Bool
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
        .disabled(isEmpty)
    }
    
}
