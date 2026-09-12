import SwiftUI

struct LunaView: View {
    
    // MARK: - Public Properties
    
    let state: LunaState
    let background: LunaBackgroundImage
    let onImageTap: (() -> Void)
    
    // MARK: - Private Properties
    
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
    
}
