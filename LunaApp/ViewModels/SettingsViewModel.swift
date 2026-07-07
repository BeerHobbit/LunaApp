import Foundation
import Combine

@MainActor
@Observable
final class SettingsViewModel {
    
    var settings: Settings
    var hasChanges: Bool {
        settings != savedSettings
    }
    
    private var savedSettings: Settings
    private let settingsStorage: SettingsStorageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(storage: SettingsStorageServiceProtocol) {
        self.settingsStorage = storage
        let current = settingsStorage.load()
        settings = current
        savedSettings = current
        observeSettings()
    }
    
    func saveChanges() {
        settingsStorage.save(settings)
        savedSettings = settings
    }
    
    private func observeSettings() {
        settingsStorage.settingsPublisher
            .sink { [weak self] newSettings in
                self?.settings = newSettings
            }
            .store(in: &cancellables)
    }
    
}
