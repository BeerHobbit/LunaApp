import Foundation

@MainActor
@Observable
final class ChatViewModel {
    
    // MARK: - Public Properties
    
    private(set) var messages: [Message] = []
    private(set) var lunaState: LunaState = LunaState(emotion: .greetings, isGlitched: false)
    private(set) var isAnswerLoading: Bool = false
    var inputState: InputState = InputState(input: "")
    var errorAlert: AlertState?
    var isErrorAlertPresented: Bool = false
    
    // MARK: - Private Properties
    
    private var storage: MessageStorageServiceProtocol
    private let glitchingTime: Double = 0.75
    
    // MARK: - Init
    
    init(storage: MessageStorageServiceProtocol) {
        self.storage = storage
        addGreetingIfNeeded()
        bindMessages()
    }
    
    // MARK: - Public Methods
    
    func sendMessage() {
        let input = inputState.input
        guard !input.isEmpty else { return }
        inputState.clear()
        
        addUserMessage(with: input)
        processLunaResponse()
    }
    
    func glitchLuna() {
        Task {
            lunaState.isGlitched = true
            defer { lunaState.isGlitched = false }
            
            try? await Task.sleep(for: .seconds(glitchingTime))
        }
    }
    
    func deleteMessage(_ message: Message) {
        do {
            try storage.delete(message)
        } catch {
            handleError(error)
        }
    }
    
    func deleteAllMessages() {
        do {
            try storage.deleteAll()
        } catch {
            handleError(error)
        }
    }
    
    // MARK: - Private Methods
    
    private func processLunaResponse() {
        Task {
            lunaState.isGlitched = true
            isAnswerLoading = true
            defer {
                lunaState.isGlitched = false
                isAnswerLoading = false
            }
            
            await simulateLunaAnswer()
            
            changeEmotion()
        }
    }
    
    private func addUserMessage(with text: String) {
        let message = Message(
            id: UUID(),
            text: text,
            sender: .user,
            createdAt: .now
        )
        
        do {
            try storage.save(message)
        } catch {
            handleError(error)
        }
    }
    
    private func addGreetingIfNeeded() {
        do {
            guard try storage.isEmpty() else { return }
            let message = Message(
                id: UUID(),
                text: String(localized: .messageGreeting),
                sender: .luna,
                createdAt: Date.now
            )
            try storage.save(message)
        } catch {
            handleError(error)
        }
    }
    
    private func changeEmotion() {
        lunaState.emotion = LunaEmotion.allCases.randomElement() ?? .greetings
    }
    
    private func simulateLunaAnswer() async {
        try? await Task.sleep(for: .seconds(glitchingTime))
        addMockAnswer()
    }
    
    private func addMockAnswer() {
        let answer = Message(
            id: UUID(),
            text: "Приветик! Я пока не умею отвечать осмысленно, но я обязательно стану умнее!)",
            sender: .luna,
            createdAt: .now
        )
        
        do {
            try storage.save(answer)
        } catch {
            handleError(error)
        }
    }
    
    private func bindMessages() {
        storage.startObservation { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let messages):
                self.messages = messages
            case .failure(let error):
                handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error, title: String? = nil) {
        errorAlert = AlertState(
            title: title ?? String(localized: .alertError),
            message: error.localizedDescription
        )
        isErrorAlertPresented = true
    }
    
}
