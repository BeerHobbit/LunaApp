import SwiftUI

@main
struct LunaAppApp: App {
    
    @State var messageStorageService: MessageStorageServiceProtocol = MessageStorageService()
    
    var body: some Scene {
        WindowGroup {
            MainView(messageStorage: messageStorageService)
        }
    }
}
