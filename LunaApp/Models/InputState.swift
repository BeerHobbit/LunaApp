import Foundation

struct InputState {
    var input: String
    var sendingIsDisabled: Bool {
        input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    mutating func clear() {
        input = ""
    }
}
