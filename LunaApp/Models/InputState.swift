import Foundation

struct InputState {
    var input: String
    let characterLimit: Int
    var isInputEmpty: Bool {
        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var isLimitReached: Bool {
        input.unicodeScalars.count > characterLimit
    }
    
    mutating func clear() {
        input = ""
    }
}
