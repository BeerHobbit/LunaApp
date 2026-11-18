import SwiftUI

struct MessageListView: View {
    
    // MARK: - Private Properties
    
    @State private var isInitialLoad: Bool = true
    @State private var isOnBottom: Bool = false
    private let messages: [Message]
    private let isFocused: Bool
    private let onMessageCopy: (Message) -> Void
    private let onMessageDelete: (Message) -> Void
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: AppTheme.Spacings.medium) {
                    ForEach(messages) { message in
                        MessageBubbleView(
                            message: message,
                            onCopy: onMessageCopy,
                            onDelete: onMessageDelete
                        )
                        .onAppear {
                            if isLast(message) {
                                isOnBottom = true
                            }
                        }
                        .onDisappear {
                            if isLast(message) {
                                isOnBottom = false
                            }
                        }
                    }
                }
            }
            .onChange(of: messages) {
                scrollToBottom(proxy)
            }
            .onChange(of: isFocused) {
                scrollToBottomOnFocus(proxy)
            }
            .onAppear {
                scrollToBottom(proxy)
            }
        }
    }
    
    // MARK: - Init
    
    init(
        messages: [Message],
        isFocused: Bool,
        onMessageCopy: @escaping (Message) -> Void,
        onMessageDelete: @escaping (Message) -> Void
    ) {
        self.messages = messages
        self.isFocused = isFocused
        self.onMessageCopy = onMessageCopy
        self.onMessageDelete = onMessageDelete
    }
    
    // MARK: - Private Methods
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        guard let lastId = messages.last?.id else { return }
        guard isInitialLoad || isOnBottom else { return }
        
        if isInitialLoad {
            proxy.scrollTo(lastId, anchor: .bottom)
            isInitialLoad = false
            return
        }
        
        withAnimation(.easeOut(duration: AppTheme.Animations.duration)) {
            proxy.scrollTo(lastId, anchor: .bottom)
        }
    }
    
    @MainActor
    private func scrollToBottomOnFocus(_ proxy: ScrollViewProxy) {
        guard let lastId = messages.last?.id else { return }
        guard isFocused || isOnBottom else { return }
        
        func scrollToLast() {
            withAnimation(.smooth(duration: AppTheme.Animations.shortDuration)) {
                proxy.scrollTo(lastId, anchor: .bottom)
            }
        }
        
        if isFocused {
            Task {
                try? await Task.sleep(for: .seconds(AppTheme.Animations.delay))
                scrollToLast()
            }
        } else {
            scrollToLast()
        }
    }
    
    private func isLast(_ message: Message) -> Bool {
        return message.id == messages.last?.id
    }
    
}
