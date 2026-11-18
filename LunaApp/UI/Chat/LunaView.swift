import SwiftUI

struct LunaView: View {
    
    // MARK: - Private Properties
    
    private let state: LunaState
    private let background: LunaBackgroundImage
    private let onImageTap: (() -> Void)
    private static let backgroundRatio: CGFloat = 2
    private static let lunaRatio: CGFloat = 1
    
    // MARK: - Body
    
    var body: some View {
        Image(background.image)
            .resizable()
            .aspectRatio(LunaView.backgroundRatio, contentMode: .fit)
            .overlay(alignment: .bottom) {
                APNGView(image: state.animatedImage)
                    .aspectRatio(LunaView.lunaRatio, contentMode: .fit)
                    .onTapGesture { onImageTap() }
            }
            .clipped()
            .border(Color.LunaColors.violet, width: AppTheme.Components.borderWidth)
    }
    
    // MARK: - Init
    
    init(
        state: LunaState,
        background: LunaBackgroundImage,
        onImageTap: @escaping () -> Void
    ) {
        self.state = state
        self.background = background
        self.onImageTap = onImageTap
    }
    
}
