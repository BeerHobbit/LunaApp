import Foundation
import Combine

@MainActor
@Observable
final class ChatViewModel {
    
    // MARK: - Public Properties
    
    private(set) var messages: [Message] = []
    private(set) var lunaState: LunaState = LunaState(emotion: .greetings, isGlitched: false)
    private(set) var isAnswerLoading: Bool = false
    private(set) var settings: Settings
    var inputState: InputState = InputState(input: "")
    var errorAlert: AlertState?
    
    // MARK: - Private Properties
    
    private let settingsStorage: any SettingsStorageServiceProtocol
    private let storageFactory: any MessageStorageFactoryProtocol
    private var storage: any MessageStorageServiceProtocol
    private let chatService: any ChatServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private static let glitchingTime: Double = 0.75
    private static let historyLimit: Int = 20
    
    // MARK: - Init
    
    init(
        settingsStorage: SettingsStorageServiceProtocol,
        storageFactory: MessageStorageFactoryProtocol,
        chatService: ChatServiceProtocol
    ) {
        let savedSettings = settingsStorage.load()
        
        self.settingsStorage = settingsStorage
        self.settings = savedSettings
        self.storageFactory = storageFactory
        self.chatService = chatService
        do {
            self.storage = try storageFactory.makeStorage(shouldSave: savedSettings.shouldSave)
        } catch {
            self.storage = InMemoryMessageStorageService()
            handleError(
                error,
                retryAction: { [weak self] in
                    self?.changeStorage(shouldSave: savedSettings.shouldSave)
                })
        }
        addGreetingIfNeeded()
        observeMessages()
        observeSettings()
    }
    
    // MARK: - Public Methods
    
    func sendMessage() {
        guard let message = makeUserMessage() else { return }
        processMessage(message)
    }
    
    func glitchLuna() {
        Task {
            lunaState.isGlitched = true
            defer { lunaState.isGlitched = false }
            
            try? await Task.sleep(for: .seconds(ChatViewModel.glitchingTime))
        }
    }
    
    func deleteMessage(_ message: Message) {
        do {
            try storage.delete(message)
        } catch {
            handleError(
                error,
                retryAction: { [weak self] in
                    self?.deleteMessage(message)
                })
        }
    }
    
    func deleteAllMessages() {
        do {
            try storage.deleteAll()
        } catch {
            handleError(
                error,
                retryAction: { [weak self] in
                    self?.deleteAllMessages()
                })
        }
    }
    
    // MARK: - Private Methods
    
    private func observeMessages() {
        storage.startObservation { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let messages):
                self.messages = messages
            case .failure(let error):
                handleError(
                    error,
                    retryAction: { [weak self] in
                        self?.observeMessages()
                    })
            }
        }
    }
    
    private func observeSettings() {
        settingsStorage.settingsPublisher
            .sink { [weak self] newSettings in
                guard let self else { return }
                
                let shouldChangeStorage = settings.shouldSave != newSettings.shouldSave
                settings = newSettings
                
                if shouldChangeStorage {
                    changeStorage(shouldSave: settings.shouldSave)
                }
            }
            .store(in: &cancellables)
    }
    
    private func addGreetingIfNeeded() {
        guard storage.isEmpty() else { return }
        let message = Message(
            id: UUID(),
            text: String(localized: .messageGreeting),
            sender: .luna,
            createdAt: Date.now
        )
        try? storage.save(message)
    }
    
    private func makeUserMessage() -> Message? {
        let input = inputState.input
        guard !input.isEmpty else { return nil }
        inputState.clear()
        
        return Message(
            id: UUID(),
            text: input,
            sender: .user,
            createdAt: .now
        )
    }
    
    private func processMessage(_ message: Message) {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                try storage.save(message)
                let history = storage.fetchLastMessages(limit: Self.historyLimit)
                try await fetchReply(history: history)
            } catch {
                handleError(
                    error,
                    retryAction: { [weak self] in
                        self?.processMessage(message)
                    },
                    cancelAction: { [weak self] in
                        self?.cancelMessage(message)
                    })
            }
        }
    }
    
    private func fetchReply(history: [Message]) async throws {
        setLoading(true)
        defer { setLoading(false) }
        
        let reply = try await chatService.fetch(history: history)
        try storage.save(reply)
        changeEmotion()
    }
    
    private func setLoading(_ isLoading: Bool) {
        lunaState.isGlitched = isLoading
        isAnswerLoading = isLoading
    }
    
    private func changeEmotion() {
        lunaState.emotion = LunaEmotion.allCases.randomElement() ?? .greetings
    }
    
    private func handleError(
        _ error: Error,
        retryAction: (() -> Void)? = nil,
        cancelAction: (() -> Void)? = nil
    ) {
        errorAlert = AlertState(
            message: error.localizedDescription,
            retryAction: retryAction,
            cancelAction: cancelAction
        )
    }
    
    private func cancelMessage(_ message: Message) {
        try? storage.delete(message)
        inputState.input = message.text
    }
    
    private func changeStorage(shouldSave: Bool) {
        do {
            let newStorage = try storageFactory.makeStorage(shouldSave: shouldSave)
            deleteAllMessages()
            storage = newStorage
            
            addGreetingIfNeeded()
            observeMessages()
        } catch {
            handleError(
                error,
                retryAction: { [weak self] in
                    self?.changeStorage(shouldSave: shouldSave)
                })
        }
    }
    
}
