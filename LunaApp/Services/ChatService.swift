// MARK: - Protocol

protocol ChatServiceProtocol {
    func fetch(history: [Message]) async throws -> Message
}

final class ChatService: ChatServiceProtocol {
    
    // MARK: - Private Properties
    
    private let client: any NetworkClientProtocol
    
    // MARK: - Init
    
    init(client: any NetworkClientProtocol) {
        self.client = client
    }
    
    // MARK: - Public Methods
    
    func fetch(history: [Message]) async throws -> Message {
        let request = ChatRequest(messages: history)
        return try await client.fetch(request.buildRequest())
    }
    
}
