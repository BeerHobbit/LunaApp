import Foundation
import RealmSwift

enum Sender: String, PersistableEnum {
    case user
    case luna
}

struct Message: Identifiable, Equatable {
    let id: UUID
    let text: String
    let sender: Sender
}

extension Message {
    init(from realmObject: MessageObject) {
        self.id = realmObject.id
        self.text = realmObject.text
        self.sender = realmObject.sender
    }
}
