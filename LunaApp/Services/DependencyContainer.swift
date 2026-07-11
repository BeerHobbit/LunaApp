import Foundation

@MainActor
@Observable
final class DependencyContainer {
    
    private let settingsStorageService: SettingsStorageServiceProtocol
    private let messageStorageFactory: MessageStorageFactoryProtocol
    
    init() {
        self.settingsStorageService = SettingsStorageService()
        self.messageStorageFactory = MessageStorageFactory()
    }
    
    init(
        settingsStorageService: SettingsStorageServiceProtocol,
        messageStorageFactory: MessageStorageFactoryProtocol
    ) {
        self.settingsStorageService = settingsStorageService
        self.messageStorageFactory = messageStorageFactory
    }
    
    func makeChatViewModel() -> ChatViewModel {
        ChatViewModel(
            settingsStorage: settingsStorageService,
            storageFactory: messageStorageFactory
        )
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(storage: settingsStorageService)
    }
    
}
