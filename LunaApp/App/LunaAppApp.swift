import SwiftUI

@main
struct LunaAppApp: App {
    
    let mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: mainViewModel)
        }
    }
}
