import APNGKit

struct LunaState {
    var emotion: LunaEmotion
    var isGlitched: Bool
    var animatedImage: APNGImage? {
        emotion.animatedImage(isGlitched: isGlitched)
    }
}

