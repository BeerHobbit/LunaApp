import DeveloperToolsSupport

enum BackgroundImage: String, CaseIterable {
    case standard
    
    var image: ImageResource {
        switch self {
        case .standard: .background
        }
    }
    
}
