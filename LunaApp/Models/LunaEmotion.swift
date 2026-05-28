import APNGKit

enum LunaEmotion: String, CaseIterable {
    case angry, greetings, heart, joy, sleep, smoke
    
    func animatedImage(isGlitched: Bool) throws -> APNGImage {
        let name = "animation_\(rawValue)\(isGlitched ? "_glitched" : "")"
        return try APNGImage(named: name)
    }
}
