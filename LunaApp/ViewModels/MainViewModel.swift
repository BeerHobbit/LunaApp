import Foundation

@Observable
final class MainViewModel {
    
    // MARK: - Public Properties
    
    var messages: [Message] = [
        Message(
            id: UUID(),
            text: "Привет! Меня зовут Луна, я твой личный собеседник с искуственным интеллектом",
            sender: .luna
        ),
        Message(
            id: UUID(),
            text: "Привет, Луна! Расскажи, что ты умеешь делать?",
            sender: .user
        ),
        Message(
            id: UUID(),
            text: "Если честно, пока ничего) Разработчик пока не реализовал работу с сетью, но он очень старается!",
            sender: .luna
        ),
        Message(
            id: UUID(),
            text: "Что ж, с нетерпением жду!)",
            sender: .user
        )
    ]
    
    var currentInput: String = ""
    var sendingIsDisabled: Bool {
        currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var emotion: LunaEmotion = .greetings
    var isGlitchedEmotion: Bool = false
    
    // MARK: - Public Methods
    
    func sendMessage() {
        let text = currentInput
        currentInput = ""
        
        let newMessage = Message(
            id: UUID(),
            text: text,
            sender: .user
        )
        messages.append(newMessage)
        
        isGlitchedEmotion = true
        Task {
            try? await Task.sleep(for: .seconds(0.75))
            await MainActor.run {
                isGlitchedEmotion = false
                changeEmotion()
                sendAnswer()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func sendAnswer() {
        let answer = Message(
            id: UUID(),
            text: "Приветик! Я пока не умею отвечать осмысленно, но я обязательно стану умнее!)",
            sender: .luna
        )
        messages.append(answer)
    }
    
    private func changeEmotion() {
        emotion = LunaEmotion.allCases.randomElement() ?? .greetings
    }
    
}
