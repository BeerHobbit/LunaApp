import Foundation
import RealmSwift
import Realm

// MARK: - Protocol

protocol MessageStorageServiceProtocol: AnyObject {
    func startObservation(onUpdate: @escaping (Result<[Message], Error>) -> Void)
    func save(_ message: Message) throws
    func delete(_ message: Message) throws
    func deleteAll() throws
    func isEmpty() throws -> Bool
    func fetchLastMessages(limit: Int) throws -> [Message]
}

// MARK: - Errors

enum MessageStorageError: LocalizedError {
    case messageNotFound
    
    var errorDescription: String? {
        switch self {
        case .messageNotFound: String(localized: .errorMessageNotFound)
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
            throw MessageStorageError.messageNotFound
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
    
    func isEmpty() throws -> Bool {
        let realm = try Realm()
        return realm.objects(MessageObject.self).isEmpty
    }
    
    func fetchLastMessages(limit: Int) throws -> [Message] {
        let realm = try Realm()
        let objects = realm.objects(MessageObject.self)
            .sorted(by: \.createdAt, ascending: false)
            .prefix(limit)
            .reversed()
        return Self.mapToMessage(objects)
    }
    
    // MARK: - Private Methods
    
    private static func mapToMessage(_ objects: some Sequence<MessageObject>) -> [Message] {
        objects.map { Message(from: $0) }
    }
    
    // MARK: - Deinit
    
    deinit {
        token?.invalidate()
    }
    
}
