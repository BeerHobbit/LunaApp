import APNGKit

enum LunaEmotion: String, CaseIterable {
    case angry, greetings, heart, joy, sleep, smoke
    
    func animatedImage(isGlitched: Bool) -> APNGImage? {
        let name = "animation_\(rawValue)\(isGlitched ? "_glitched" : "")"
        
        do {
            return try APNGImage(named: name)
        } catch {
            assertionFailure("Failed to load image for \(self): \(error)")
            return nil
        }
    }
}
