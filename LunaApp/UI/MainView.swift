import SwiftUI

struct MainView: View {
    
    // MARK: - Private Properties
    
    @State private var viewModel: MainViewModel = MainViewModel(storage: MessageStorageService())
    @FocusState private var isFocused: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: .zero) {
            LunaView(state: viewModel.lunaState) {
                viewModel.glitchLuna()
            }
            .background(AppTheme.Effects.standardShadow)
            .zIndex(1)
            .padding(.horizontal, AppTheme.Spacings.large)
            .padding(.top, AppTheme.Spacings.medium)
            
            ChatView(
                messages: viewModel.messages,
                isFocused: isFocused
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
    }
    
}

#Preview {
    MainView()
}
