import SwiftUI

@main
struct LunaAppApp: App {
    
    @State private var container = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: container.makeChatViewModel())
                .environment(container)
        }
    }
    
}
