import Foundation
import Combine

// MARK: - Protocol

protocol SettingsStorageServiceProtocol: AnyObject {
    var settingsPublisher: AnyPublisher<Settings, Never> { get }
    func save(_ settings: Settings)
    func load() -> Settings
}

final class SettingsStorageService: SettingsStorageServiceProtocol {
    
    // MARK: - Public Properties
    
    var settingsPublisher: AnyPublisher<Settings, Never> {
        settingsSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private Types
    
    private enum Keys: String {
        case shouldSave
        case background
        case lunaBackground
    }
    
    // MARK: - Private Properties
    
    private let defaults = UserDefaults.standard
    private lazy var settingsSubject = CurrentValueSubject<Settings, Never>(load())
    
    // MARK: - Init
    
    init() {
        registerDefaultValues()
    }
    
    // MARK: - Public Methods
    
    func save(_ settings: Settings) {
        defaults.set(settings.shouldSave, forKey: Keys.shouldSave.rawValue)
        defaults.set(settings.background.rawValue, forKey: Keys.background.rawValue)
        defaults.set(settings.lunaBackground.rawValue, forKey: Keys.lunaBackground.rawValue)
        
        settingsSubject.send(settings)
    }
    
    func load() -> Settings {
        let shouldSave = defaults.bool(forKey: Keys.shouldSave.rawValue)
        let backgroundString = defaults.string(forKey: Keys.background.rawValue) ?? ""
        let lunaBackgroundString = defaults.string(forKey: Keys.lunaBackground.rawValue) ?? ""
        
        return Settings(
            shouldSave: shouldSave,
            background: BackgroundImage(rawValue: backgroundString) ?? .retrowaveGrid,
            lunaBackground: LunaBackgroundImage(rawValue: lunaBackgroundString) ?? .window
        )
    }
    
    // MARK: - Private Methods
    
    private func registerDefaultValues() {
        defaults.register(defaults: [
            Keys.shouldSave.rawValue: true,
            Keys.background.rawValue: BackgroundImage.retrowaveGrid.rawValue,
            Keys.lunaBackground.rawValue: LunaBackgroundImage.window.rawValue
        ])
    }
    
}
