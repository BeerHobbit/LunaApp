import DeveloperToolsSupport

protocol ImageResourceProviding: Equatable, CaseIterable, RawRepresentable where RawValue == String {
    var image: ImageResource { get }
}

enum BackgroundImage: String, ImageResourceProviding {
    case horizon
    case microchip
    case wire
    
    var image: ImageResource {
        switch self {
        case .horizon: .horizonBackground
        case .microchip: .microchipBackground
        case .wire: .wireBackground
        }
    }
}

enum LunaBackgroundImage: String, ImageResourceProviding {
    case room
    case roof
    case cyberspace
    
    var image: ImageResource {
        switch self {
        case .room: .room
        case .roof: .roof
        case .cyberspace: .cyberspace
        }
    }
}
