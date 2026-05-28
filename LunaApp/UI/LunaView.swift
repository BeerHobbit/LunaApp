import SwiftUI

struct LunaView: View {
    
    // MARK: - Bindings
    
    @FocusState.Binding var isFocused: Bool
    
    // MARK: - Public Properties
    
    let state: LunaState
    var onImageTap: (() -> Void)?
    
    // MARK: - Constants
    
    private enum Constants {
        static let frameHeight: CGFloat = 170
        static let borderWidth: CGFloat = 3
        
        static let shadowOpacity: Double = 0.35
        static let shadowRadius: CGFloat = 0
        static let shadowXOffset: CGFloat = 0
        static let shadowYOffset: CGFloat = 6
    }
    
    // MARK: - Private Properties
    
    private var shadowStyle: some ShapeStyle {
        Color.LunaColors.gray
            .shadow(
                .drop(
                    color: .black.opacity(Constants.shadowOpacity),
                    radius: Constants.shadowRadius,
                    x: Constants.shadowXOffset,
                    y: Constants.shadowYOffset
                )
            )
    }
    
    // MARK: - Body
    
    var body: some View {
        Image(.lunaViewBackground)
            .resizable()
            .frame(height: Constants.frameHeight)
            .background(shadowStyle)
            .zIndex(1)
            .overlay {
                APNGView(image: state.animatedImage)
                    .frame(width: Constants.frameHeight, height: Constants.frameHeight)
                    .onTapGesture {
                        onImageTap?()
                    }
            }
            .border(Color.LunaColors.violet, width: Constants.borderWidth)
            .onTapGesture {
                isFocused = false
            }
    }
    
}

#Preview {
    @FocusState var isFocused: Bool
    LunaView(
        isFocused: $isFocused,
        state: LunaState(
            emotion: .greetings,
            isGlitched: false
        )
    )
}
