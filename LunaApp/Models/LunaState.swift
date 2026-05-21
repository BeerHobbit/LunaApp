import APNGKit

struct LunaState {
    var emotion: LunaEmotion
    var isGlitched: Bool
    
    var animatedImage: APNGImage? {
        do {
            return try emotion.animatedImage(isGlitched: isGlitched)
        } catch {
            assertionFailure("Failed to load image for \(emotion), error: \(error)")
            return nil
        }
    }
}

