import Foundation
import APNGKit

enum LunaEmotion: String, CaseIterable {
    case angry, greetings, heart, joy, sleep, smoke
    
    var keywords: Set<String> {
        switch self {
        case .angry: ["*сердито*", "*обиженно*"]
        case .greetings: ["*дружелюбно*", "*нейтрально*"]
        case .heart: ["*нежно*", "*тепло*", "*заботливо*"]
        case .joy: ["*радостно*", "*счастливо*", "*удивлённо*"]
        case .sleep: ["*сонно*", "*устало*"]
        case .smoke: ["*задумчиво*", "*мечтательно*", "*меланхолично*"]
        }
    }
    
    static func find(in text: String) -> LunaEmotion {
        let normalized = text.lowercased()
        
        return allCases.first {
            $0.keywords.contains {
                normalized.contains($0)
            }
        } ?? .greetings
    }
    
    func animatedImage(isGlitched: Bool) -> APNGImage? {
        let name = "animation_\(rawValue)\(isGlitched ? "_glitched" : "")"
        
        do {
            return try APNGImage(named: name)
        } catch {
            assertionFailure("Failed to load image for \(self): \(error.localizedDescription)")
            return nil
        }
    }
}
