import SwiftUI

struct LunaView: View {
    
    // MARK: - Public Properties
    
    let state: LunaState
    let onImageTap: (() -> Void)
    
    // MARK: - Body
    
    var body: some View {
        Image(.lunaViewBackground)
            .resizable()
            .frame(height: AppTheme.Components.lunaViewHeight)
            .overlay {
                APNGView(image: state.animatedImage)
                    .frame(
                        width: AppTheme.Components.lunaViewHeight,
                        height: AppTheme.Components.lunaViewHeight,
                    )
                    .onTapGesture { onImageTap() }
            }
            .border(Color.LunaColors.violet, width: AppTheme.Components.borderWidth)
    }
    
}
