import SwiftUI

struct ChatView: View {
    
    // MARK: - Private Properties
    
    @State private var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool
    @Environment(DependencyContainer.self) private var container
    @State private var showDeleteAllAlert = false
    @State private var showSettings: Bool = false
    private var isMessagesEmpty: Bool { viewModel.messages.isEmpty }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: .zero) {
            LunaView(
                state: viewModel.lunaState,
                background: viewModel.settings.lunaBackground
            ) {
                viewModel.glitchLuna()
            }
            .background(AppTheme.Effects.standardShadow)
            .zIndex(1)
            .overlay(alignment: .top) {
                MenuView(
                    isEmpty: isMessagesEmpty,
                    onDeleteAllTap: { showDeleteAllAlert = true },
                    onSettingsTap: { showSettings = true }
                )
                .padding(AppTheme.Spacings.small)
            }
            .overlay(alignment: .bottomLeading) {
                IsTypingView(isTyping: viewModel.isAnswerLoading)
                    .padding(AppTheme.Spacings.xSmall)
            }
            .padding(.horizontal, AppTheme.Spacings.large)
            .padding(.top, AppTheme.Spacings.medium)
            
            MessageListView(
                messages: viewModel.messages,
                isFocused: isFocused,
                onMessageCopy: { message in
                    copyText(from: message)
                },
                onMessageDelete: { message in
                    delete(message)
                }
            )
            .contentMargins(
                .horizontal,
                AppTheme.Spacings.large - AppTheme.Components.tailSize,
                for: .scrollContent
            )
            .contentMargins(
                .vertical,
                AppTheme.Spacings.medium,
                for: .scrollContent
            )
            .clipped()
        }
        .safeAreaInset(edge: .bottom, spacing: .zero) {
            MessageInputView(
                state: $viewModel.inputState,
                isFocused: $isFocused
            ) {
                viewModel.sendMessage()
            }
            .padding(.horizontal, AppTheme.Spacings.large)
            .padding(.bottom, AppTheme.Spacings.medium)
        }
        .background(
            Image(viewModel.settings.background.image)
                .resizable()
                .ignoresSafeArea()
        )
        .onTapGesture { isFocused = false }
        .preferredColorScheme(.dark)
        
        .alert(.alertDeleteAll, isPresented: $showDeleteAllAlert) {
            deleteAllAlertButtons
        }
        .alert(
            viewModel.errorAlert?.title ?? "",
            isPresented: $viewModel.isErrorAlertPresented,
            presenting: viewModel.errorAlert
        ) { _ in
            Button(.alertOk) {
                viewModel.errorAlert = nil
            }
        } message: { alert in
            Text(alert.message)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(viewModel: container.makeSettingsViewModel())
        }
        
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var deleteAllAlertButtons: some View {
        Button(
            .alertConfirmDeletion,
            role: .destructive
        ) {
            viewModel.deleteAllMessages()
        }
        Button(.alertCancel, role: .cancel) {}
    }
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Private Methods
    
    private func copyText(from message: Message) {
        UIPasteboard.general.string = message.text
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    private func delete(_ message: Message) {
        viewModel.deleteMessage(message)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
}

#Preview {
    let container = DependencyContainer()
    ChatView(viewModel: container.makeChatViewModel())
        .environment(container)
}
