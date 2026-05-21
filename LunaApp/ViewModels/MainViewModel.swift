import Foundation

@Observable
final class MainViewModel {
    
    // MARK: - Public Properties
    
    var messages: [Message] = (0...50).map { i in
        Message(
            id: UUID(),
            text: "Сообщение \(i)",
            sender: i.isMultiple(of: 2) ? .luna : .user
        )
    }
    
    var inputState: InputState = InputState(input: "")
    var lunaState: LunaState = LunaState(
        emotion: .greetings,
        isGlitched: false
    )
    
    // MARK: - Public Methods
    
    func sendMessage() {
        let text = inputState.input
        inputState.clear()
        
        let newMessage = Message(
            id: UUID(),
            text: text,
            sender: .user
        )
        messages.append(newMessage)
        
        lunaState.isGlitched = true
        Task {
            try? await Task.sleep(for: .seconds(0.75))
            await MainActor.run {
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
        lunaState.emotion = LunaEmotion.allCases.randomElement() ?? .greetings
        lunaState.isGlitched = false
    }
    
}
