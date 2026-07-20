import SwiftUI

struct LunaView: View {
    
    // MARK: - Public Properties
    
    let state: LunaState
    let background: LunaBackgroundImage
    let onImageTap: (() -> Void)
    
    // MARK: - Body
    
    var body: some View {
        Image(background.image)
            .resizable()
            .aspectRatio(2, contentMode: .fit)
            .overlay(alignment: .bottom) {
                APNGView(image: state.animatedImage)
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture { onImageTap() }
            }
            .clipped()
            .border(Color.LunaColors.violet, width: AppTheme.Components.borderWidth)
    }
    
}
