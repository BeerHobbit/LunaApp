import SwiftUI
import APNGKit

struct APNGView: UIViewRepresentable {
    
    // MARK: - Public Properties
    
    let image: APNGImage?
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> APNGImageView {
        let imageView = APNGImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return imageView
    }
    
    func updateUIView(_ uiView: APNGImageView, context: Context) {
        uiView.image = image
    }
    
}
