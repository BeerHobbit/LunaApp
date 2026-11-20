import Foundation

@MainActor
@Observable
final class DependencyContainer {
    
    private let settingsStorageService: any SettingsStorageServiceProtocol
    private let messageStorageFactory: any MessageStorageFactoryProtocol
    private let networkClient: any NetworkClientProtocol
    private let chatService: any ChatServiceProtocol
    private let notificationManager: NotificationManager
    
    init() {
        self.settingsStorageService = SettingsStorageService()
        self.messageStorageFactory = MessageStorageFactory()
        self.networkClient = NetworkClient()
        self.chatService = ChatService(client: networkClient)
        self.notificationManager = NotificationManager()
    }
    
    init(
        settingsStorageService: SettingsStorageServiceProtocol,
        messageStorageFactory: MessageStorageFactoryProtocol,
        networkClient: NetworkClientProtocol,
        chatService: ChatServiceProtocol,
        notificationManager: NotificationManager
    ) {
        self.settingsStorageService = settingsStorageService
        self.messageStorageFactory = messageStorageFactory
        self.networkClient = networkClient
        self.chatService = chatService
        self.notificationManager = notificationManager
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
