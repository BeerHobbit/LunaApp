import Foundation

@MainActor
@Observable
final class DependencyContainer {
    
    private let settingsStorageService: any SettingsStorageServiceProtocol
    private let messageStorageFactory: any MessageStorageFactoryProtocol
    private let networkClient: any NetworkClientProtocol
    private let chatService: any ChatServiceProtocol
    
    init() {
        self.settingsStorageService = SettingsStorageService()
        self.messageStorageFactory = MessageStorageFactory()
        self.networkClient = NetworkClient()
        self.chatService = ChatService(client: networkClient)
    }
    
    init(
        settingsStorageService: SettingsStorageServiceProtocol,
        messageStorageFactory: MessageStorageFactoryProtocol,
        networkClient: NetworkClientProtocol,
        chatService: ChatServiceProtocol
    ) {
        self.settingsStorageService = settingsStorageService
        self.messageStorageFactory = messageStorageFactory
        self.networkClient = networkClient
        self.chatService = chatService
    }
    
    func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(
            settingsStorage: settingsStorageService,
            storageFactory: messageStorageFactory,
            chatService: chatService
        )
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(storage: settingsStorageService)
    }
    
}
