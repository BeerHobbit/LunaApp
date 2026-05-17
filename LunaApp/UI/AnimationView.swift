import SwiftUI
import APNGKit

struct AnimationView: UIViewRepresentable {
    
    // MARK: - Public Properties
    
    let emotion: LunaEmotion
    let isGlitched: Bool
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> APNGImageView {
        let image = makeImage()
        let imageView = APNGImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return imageView
    }
    
    func updateUIView(_ uiView: APNGImageView, context: Context) {
        let image = makeImage()
        uiView.image = image
    }
    
    // MARK: - Private Methods
    
    private func makeImage() -> APNGImage? {
        do {
            return try emotion.animatedImage(isGlitched: isGlitched)
        } catch {
            assertionFailure("Failed to load image for \(emotion), error: \(error)")
            return nil
        }
    }
    
}
