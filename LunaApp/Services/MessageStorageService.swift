import Foundation
import RealmSwift
import Realm

// MARK: - Protocol

protocol MessageStorageServiceProtocol: AnyObject {
    func startObservation(onUpdate: @escaping (Result<[Message], Error>) -> Void)
    func save(_ message: Message) throws
    func delete(_ message: Message) throws
    func deleteAll() throws
}

extension MessageStorageServiceProtocol {
    func addGreetingMessage() throws {
        let message = Message(
            id: UUID(),
            text: String(localized: .messageGreeting),
            sender: .luna,
            createdAt: Date.now
        )
        try save(message)
    }
}

// MARK: - Errors

enum MessagesStorageError: LocalizedError {
    case messageNotFound
    
    var errorDescription: String? {
        switch self {
        case .messageNotFound: "Message not found in database"
        }
    }
}

final class MessageStorageService: MessageStorageServiceProtocol {
    
    // MARK: - Private Properties
    
    private var token: NotificationToken?
    
    // MARK: - Public Methods
    
    func startObservation(onUpdate: @escaping (Result<[Message], Error>) -> Void) {
        let realm: Realm
        do {
            realm = try Realm()
        } catch {
            onUpdate(.failure(error))
            return
        }
        
        let objects = realm.objects(MessageObject.self)
            .sorted(by: \.createdAt, ascending: true)
        
        if objects.isEmpty {
            do {
                try addGreetingMessage()
            } catch {
                onUpdate(.failure(error))
            }
        }
        
        token = objects.observe { changes in
            switch changes {
            case .initial(let collection),
                    .update(let collection, _, _, _):
                let messages = Self.mapToMessage(collection)
                onUpdate(.success(messages))
            case .error(let error):
                onUpdate(.failure(error))
            }
        }
    }
    
    func save(_ message: Message) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(MessageObject(from: message))
        }
    }
    
    func delete(_ message: Message) throws {
        let realm = try Realm()
        guard let object = realm.object(
            ofType: MessageObject.self,
            forPrimaryKey: message.id
        ) else {
            throw MessagesStorageError.messageNotFound
        }
        
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll() throws {
        let realm = try Realm()
        let objects = realm.objects(MessageObject.self)
        try realm.write {
            realm.delete(objects)
        }
    }
    
    // MARK: - Private Methods
    
    private static func mapToMessage(_ results: Results<MessageObject>) -> [Message] {
        Array(results.map { Message(from: $0)})
    }
    
    // MARK: - Deinit
    
    deinit {
        token?.invalidate()
    }
    
}
