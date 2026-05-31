import Foundation
import RealmSwift

final class MessageObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var text: String
    @Persisted var sender: Sender
    
}

extension MessageObject {
    convenience init(from message: Message) {
        self.init()
        self.id = message.id
        self.text = message.text
        self.sender = message.sender
    }
}
