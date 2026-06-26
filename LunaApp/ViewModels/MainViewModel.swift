import Foundation

@MainActor
@Observable
final class MainViewModel {
    
    // MARK: - Public Properties
    
    var messages: [Message] = []
    var inputState: InputState = InputState(input: "")
    var lunaState: LunaState = LunaState(emotion: .greetings, isGlitched: false)
    
    // MARK: - Private Properties
    
    private var storage: MessageStorageServiceProtocol
    private let glitchingTime: Double = 0.75
    
    // MARK: - Init
    
    init(storage: MessageStorageServiceProtocol) {
        self.storage = storage
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
            try? await Task.sleep(for: .seconds(glitchingTime))
            lunaState.isGlitched = false
        }
    }
    
    func deleteMessage(_ message: Message) {
        do {
            try storage.delete(message)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    // MARK: - Private Methods
    
    private func processLunaResponse() {
        Task {
            lunaState.isGlitched = true
            defer { lunaState.isGlitched = false}
            
            await simulateLunaAnswer()
            
            changeEmotion()
        }
    }
    
    private func addUserMessage(with text: String) {
        let newMessage = Message(
            id: UUID(),
            text: text,
            sender: .user,
            createdAt: .now
        )
        
        do {
            try storage.save(newMessage)
        } catch {
            assertionFailure(error.localizedDescription)
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
            assertionFailure(error.localizedDescription)
        }
    }
    
    private func bindMessages() {
        storage.startObservation { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let messages):
                self.messages = messages
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
}
