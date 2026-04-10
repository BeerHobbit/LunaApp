import SwiftUI

struct MainView: View {
    
    // TODO: Should be replaced with ViewModel objects
    @State private var messages: [Message] = [
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
    
    @State private var messageText = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea(.all)
            VStack(spacing: 0) {
                LunaView(
                    isFocused: $isFocused
                )
                ChatView(
                    messages: $messages,
                    isFocused: $isFocused
                )
                MessageInputView(
                    text: $messageText,
                    isFocused: $isFocused
                ) {
                    sendMessage()
                }
            }
            .padding(
                EdgeInsets(
                    top: 8,
                    leading: 16,
                    bottom: 8,
                    trailing: 16
                )
            )
        }
    }
    
    private func sendMessage() {
        let newMessage = Message(
            id: UUID(),
            text: messageText,
            sender: .user
        )
        messageText = ""
        withAnimation(.easeInOut(duration: 0.25)) {
            messages.append(newMessage)
        }
    }
    
}

#Preview {
    MainView()
}

