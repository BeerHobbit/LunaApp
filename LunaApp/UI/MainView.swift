import SwiftUI

struct MainView: View {
    
    // MARK: - Private Properties
    
    @State private var viewModel: MainViewModel = MainViewModel(storage: MessageStorageService())
    @FocusState private var isFocused: Bool
    @State private var showDeleteAllAlert = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: .zero) {
            LunaView(state: viewModel.lunaState) {
                viewModel.glitchLuna()
            }
            .background(AppTheme.Effects.standardShadow)
            .zIndex(1)
            .overlay(alignment: .top) {
                MenuView(
                    onDeleteAll: { showDeleteAllAlert = true }
                )
                .padding(AppTheme.Spacings.small)
            }
            .padding(.horizontal, AppTheme.Spacings.large)
            .padding(.top, AppTheme.Spacings.medium)
            
            ChatView(
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
            Image(.background)
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
    MainView()
}
