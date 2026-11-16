import Foundation
import RealmSwift
import Realm

// MARK: - Protocol

protocol MessageStorageServiceProtocol: AnyObject {
    func startObservation(onUpdate: @escaping (Result<[Message], Error>) -> Void)
    func save(_ message: Message) throws
    func delete(_ message: Message) throws
    func deleteAll() throws
    func isEmpty() -> Bool
    func fetchLastMessages(limit: Int) -> [Message]
}

// MARK: - Errors

enum MessageStorageError: LocalizedError {
    case initFailed(Error)
    case saveFailed(Error)
    case deleteFailed(Error)
    case deleteAllFailed(Error)
    case updateFailed(Error)
    case messageNotFound
    
    var errorDescription: String? {
        switch self {
        case .initFailed(_):
            String(localized: .errorInitFailed)
        case .saveFailed(_):
            String(localized: .errorSaveFailed)
        case .deleteFailed(_):
            String(localized: .errorDeleteFailed)
        case .deleteAllFailed(_):
            String(localized: .errorDeleteAllFailed)
        case .updateFailed(_):
            String(localized: .errorUpdateFailed)
        case .messageNotFound:
            String(localized: .errorMessageNotFound)
        }
    }
}

@MainActor
final class MessageStorageService: MessageStorageServiceProtocol {
    
    // MARK: - Private Properties
    
    private let realm: Realm
    private var token: NotificationToken?
    
    // MARK: - Init
    
    init(configuration: Realm.Configuration = .defaultConfiguration) throws {
        do {
            realm = try Realm(configuration: configuration)
        } catch {
            throw MessageStorageError.initFailed(error)
        }
    }
    
    // MARK: - Public Methods
    
    func startObservation(onUpdate: @escaping (Result<[Message], Error>) -> Void) {
        let objects = realm.objects(MessageObject.self)
            .sorted(by: \.createdAt, ascending: true)
        
        token = objects.observe { changes in
            switch changes {
            case .initial(let collection),
                    .update(let collection, _, _, _):
                let messages = Self.mapToMessage(collection)
                onUpdate(.success(messages))
            case .error(let error):
                onUpdate(.failure(MessageStorageError.updateFailed(error)))
            }
        }
    }
    
    func save(_ message: Message) throws {
        do {
            try realm.write {
                realm.add(MessageObject(from: message))
            }
        } catch {
            throw MessageStorageError.saveFailed(error)
        }
    }
    
    func delete(_ message: Message) throws {
        guard let object = realm.object(
            ofType: MessageObject.self,
            forPrimaryKey: message.id
        ) else {
            throw MessageStorageError.messageNotFound
        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            throw MessageStorageError.deleteFailed(error)
        }
    }
    
    func deleteAll() throws {
        let objects = realm.objects(MessageObject.self)
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            throw MessageStorageError.deleteAllFailed(error)
        }
    }
    
    func isEmpty() -> Bool {
        realm.objects(MessageObject.self).isEmpty
    }
    
    func fetchLastMessages(limit: Int) -> [Message] {
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
