import SwiftUI

struct ChatView: View {
    
    @Binding var messages: [Message]
    @FocusState.Binding var isFocused: Bool
    
    @Namespace private var bottom
    
    var body: some View {
        ScrollViewReader { proxy in
            GeometryReader { geometry in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        Spacer()
                            .frame(height: 0)
                        ForEach(messages) { message in
                            MessageView(
                                message: message,
                                availableWidth: geometry.size.width
                            )
                        }
                        Spacer()
                            .frame(height: 0)
                            .id(bottom)
                    }
                    .rotationEffect(.degrees(180))
                }
                .rotationEffect(.degrees(180))
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
