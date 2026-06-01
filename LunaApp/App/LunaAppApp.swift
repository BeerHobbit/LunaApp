import SwiftUI

@main
struct LunaAppApp: App {
    
    var messageStorageService: MessageStorageServiceProtocol = MessageStorageService()
    
    var body: some Scene {
        WindowGroup {
            MainView(messageStorage: messageStorageService)
        }
    }
}
