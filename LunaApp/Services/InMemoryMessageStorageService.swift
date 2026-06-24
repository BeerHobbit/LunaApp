final class InMemoryMessageStorageService: MessageStorageServiceProtocol {
    
    // MARK: - Private Properties
    
    private var messages = [Message]() {
        didSet {
            onUpdate?(.success(messages))
        }
    }
    private var onUpdate: ((Result<[Message], any Error>) -> Void)?
    
    // MARK: - Public Methods
    
    func startObservation(onUpdate: @escaping (Result<[Message], any Error>) -> Void) {
        self.onUpdate = onUpdate
        
        if messages.isEmpty {
            try? addGreetingMessage()
        }
        
        self.onUpdate?(.success(messages))
    }
    
    func save(_ message: Message) throws {
        messages.append(message)
    }
    
    func delete(_ message: Message) throws {
        messages.removeAll { $0.id == message.id }
    }
    
    func deleteAll() throws {
        messages.removeAll()
    }
    
}
