protocol MessageStorageFactoryProtocol {
    func makeStorage(shouldSave: Bool) -> MessageStorageServiceProtocol
}

final class MessageStorageFactory: MessageStorageFactoryProtocol {
    func makeStorage(shouldSave: Bool) -> any MessageStorageServiceProtocol {
        shouldSave ? MessageStorageService() : InMemoryMessageStorageService()
    }
}
