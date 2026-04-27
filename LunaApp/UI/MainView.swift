import SwiftUI

struct MainView<VM: MainViewModelProtocol>: View {
    
    // MARK: - Bindings
    
    @Bindable var viewModel: VM
    @FocusState private var isFocused: Bool
    
    // MARK: - Constants
    
    private enum Constants {
        static var vSpacing: CGFloat { 0 }
        static var hInset: CGFloat { 8 }
        static var vInset: CGFloat { 8 }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea(.all)
            VStack(spacing: Constants.vSpacing) {
                LunaView(
                    isFocused: $isFocused
                )
                ChatView(
                    messages: $viewModel.messages,
                    isFocused: $isFocused
                )
                MessageInputView(
                    text: $viewModel.currentInput,
                    isFocused: $isFocused,
                    enterIsDisabled: viewModel.sendingIsDisabled
                ) {
                    handleSendTapped()
                }
            }
            .padding(.horizontal, Constants.hInset)
            .padding(.vertical, Constants.vInset)
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSendTapped() {
        viewModel.sendMessage()
    }
    
}

#Preview {
    MainView(viewModel: MainViewModel())
}
