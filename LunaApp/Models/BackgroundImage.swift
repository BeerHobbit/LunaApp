import DeveloperToolsSupport

protocol ImageResourceProviding: Equatable, CaseIterable, RawRepresentable where RawValue == String {
    var image: ImageResource { get }
    var previewImage: ImageResource { get }
}

// TODO: Replace mock cases and images with actual ones
enum BackgroundImage: String, ImageResourceProviding {
    case retrowaveGrid
    case microchip
    case wires
    
    var image: ImageResource {
        switch self {
        case .retrowaveGrid: .retrowaveGrid
        case .microchip: .microchipTemp
        case .wires: .wiresTemp
        }
    }
    
    var previewImage: ImageResource {
        switch self {
        case .retrowaveGrid: .retrowaveGrid
        case .microchip: .microchipTemp
        case .wires: .wiresTemp
        }
    }
}

// TODO: Replace mock cases and images with actual ones
enum LunaBackgroundImage: String, ImageResourceProviding {
    case window
    case room
    case cyberspace
    
    var image: ImageResource {
        switch self {
        case .window: .lunaViewBackground
        case .room: .roomTemp
        case .cyberspace: .cyberspaceTemp
        }
    }
    
    var previewImage: ImageResource {
        switch self {
        case .window: .lunaViewBackground
        case .room: .roomTemp
        case .cyberspace: .cyberspaceTemp
        }
    }
}
