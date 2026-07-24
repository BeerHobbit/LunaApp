import SwiftUI

@main
struct LunaAppApp: App {
    
    // MARK: - Private Properties
    
    @State private var container: DependencyContainer
    @State private var chatViewModel: ChatViewModel
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: chatViewModel)
                .environment(container)
        }
    }
    
    // MARK: - Init
    
    init() {
        let container = DependencyContainer()
        self.container = container
        self.chatViewModel = container.makeChatViewModel()
    }
    
}
