import SwiftUI

struct ChatView: View {
    
    // MARK: - Bindings
    
    @Binding var messages: [Message]
    @FocusState.Binding var isFocused: Bool
    
    // MARK: - Constants
    
    private enum Constants {
        static let vStackSpacing: CGFloat = 12
        static let rotation: Double = 180
    }
    
    // MARK: - Namespaces
    
    @Namespace private var bottom
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: Constants.vStackSpacing) {
                        Spacer()
                            .frame(height: 0)
                        ForEach(messages) { message in
                            MessageBubbleView(
                                message: message,
                                availableWidth: geometry.size.width
                            )
                        }
                        .animation(.easeInOut(duration: 0.2), value: messages)
                        Spacer()
                            .frame(height: 0)
                            .id(bottom)
                    }
                    .rotationEffect(.degrees(Constants.rotation))
                }
                .rotationEffect(.degrees(Constants.rotation))
                .scrollIndicators(.hidden)
                .onChange(of: messages.count) {
                    scrollToBottom(proxy: proxy)
                }
            }
            .onTapGesture {
                isFocused = false
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func scrollToBottom(proxy: ScrollViewProxy?) {
        withAnimation(.easeInOut(duration: 0.3)) {
            proxy?.scrollTo(bottom, anchor: .bottom)
        }
    }
    
}

#Preview {
    @Previewable @State var messages: [Message] = [
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
    @FocusState var isFocused: Bool
    
    ChatView(
        messages: $messages,
        isFocused: $isFocused
    )
}
