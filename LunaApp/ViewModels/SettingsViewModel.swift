import Foundation
import Combine

@MainActor
@Observable
final class SettingsViewModel {
    
    // MARK: - Public Properties
    
    var settings: Settings
    var hasChanges: Bool {
        settings != savedSettings
    }
    
    // MARK: - Private Properties
    
    private var savedSettings: Settings
    private let settingsStorage: SettingsStorageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(storage: SettingsStorageServiceProtocol) {
        self.settingsStorage = storage
        let current = settingsStorage.load()
        self.settings = current
        self.savedSettings = current
        observeSettings()
    }
    
    // MARK: - Public Methods
    
    func saveChanges() {
        settingsStorage.save(settings)
        savedSettings = settings
    }
    
    // MARK: - Private Methods
    
    private func observeSettings() {
        settingsStorage.settingsPublisher
            .sink { [weak self] newSettings in
                self?.settings = newSettings
            }
            .store(in: &cancellables)
    }
    
}
