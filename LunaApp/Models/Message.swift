import Foundation

enum Sender {
    case user
    case luna
}

struct Message: Identifiable, Equatable {
    let id: UUID
    let text: String
    let sender: Sender
}
