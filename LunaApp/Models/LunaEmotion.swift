import APNGKit

enum LunaEmotion: String, CaseIterable {
    case angry, greetings, heart, joy, sleep, smoke
    
    func animatedImage(isGlitched: Bool) throws -> APNGImage {
        let prefix = "animation_"
        let postfix = isGlitched ? "_glitched" : ""
        
        return try APNGImage(named: prefix + self.rawValue + postfix)
    }
}
