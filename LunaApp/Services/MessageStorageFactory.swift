protocol MessageStorageFactoryProtocol {
    func makeStorage(shouldSave: Bool) throws -> MessageStorageServiceProtocol
}

final class MessageStorageFactory: MessageStorageFactoryProtocol {
    func makeStorage(shouldSave: Bool) throws -> any MessageStorageServiceProtocol {
        shouldSave
        ? try MessageStorageService()
        : InMemoryMessageStorageService()
    }
}
