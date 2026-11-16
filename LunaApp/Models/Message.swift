import Foundation
import RealmSwift

enum Sender: String, PersistableEnum, Codable {
    case user
    case luna
}

struct MessagesDTO: Encodable {
    let messages: [Message]
}

struct Message: Identifiable, Equatable {
    let id: UUID
    let text: String
    let sender: Sender
    let createdAt: Date
}

extension Message {
    init(from realmObject: MessageObject) {
        self.id = realmObject.id
        self.text = realmObject.text
        self.sender = realmObject.sender
        self.createdAt = realmObject.createdAt
    }
}

extension Message: Codable {
    enum CodingKeys: String, CodingKey {
        case text
        case sender
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        self.text = try container.decode(String.self, forKey: .text)
        self.sender = try container.decode(Sender.self, forKey: .sender)
        self.createdAt = .now
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(text, forKey: .text)
        try container.encode(sender, forKey: .sender)
    }
}
