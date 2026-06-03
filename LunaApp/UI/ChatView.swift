import SwiftUI

struct ChatView: View {
    
    // MARK: - Public Properties
    
    var messages: [Message]
    
    // MARK: - Bindings
    
    @FocusState.Binding var isFocused: Bool
    
    // MARK: - Constants
    
    private enum Constants {
        static let vStackSpacing: CGFloat = 12
        static let bottomId = "bottom"
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: Constants.vStackSpacing) {
                    Spacer()
                        .frame(height: 0)
                    ForEach(messages) { message in
                        MessageBubbleView(
                            message: message,
                        )
                    }
                    .animation(.easeInOut(duration: 0.2), value: messages)
                    Spacer()
                        .frame(height: 0)
                        .id(Constants.bottomId)
                }
            }
            .scrollIndicators(.hidden)
            .defaultScrollAnchor(.bottom)
            .onChange(of: messages.count) {
                scrollToBottom(proxy: proxy)
            }
            .onTapGesture {
                isFocused = false
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func scrollToBottom(proxy: ScrollViewProxy?) {
        withAnimation(.easeInOut(duration: 0.3)) {
            proxy?.scrollTo(Constants.bottomId, anchor: .bottom)
        }
    }
    
}

#Preview {
    let messages: [Message] = [
        Message(
            id: UUID(),
            text: "Привет! Меня зовут Луна, я твой личный собеседник с искуственным интеллектом",
            sender: .luna,
            createdAt: .now
        ),
        Message(
            id: UUID(),
            text: "Привет, Луна! Расскажи, что ты умеешь делать?",
            sender: .user,
            createdAt: .now
        ),
        Message(
            id: UUID(),
            text: "Если честно, пока ничего) Разработчик пока не реализовал работу с сетью, но он очень старается!",
            sender: .luna,
            createdAt: .now
        ),
        Message(
            id: UUID(),
            text: "Что ж, с нетерпением жду!)",
            sender: .user,
            createdAt: .now
        )
    ]
    @FocusState var isFocused: Bool
    
    ChatView(
        messages: messages,
        isFocused: $isFocused
    )
}
