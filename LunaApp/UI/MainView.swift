import SwiftUI

struct MainView: View {
    
    // MARK: - Bindings
    
    @State private var viewModel: MainViewModel
    @FocusState private var isFocused: Bool
    
    // MARK: - Constants
    
    private enum Constants {
        static var vSpacing: CGFloat = 0
        static var hInset: CGFloat = 8
        static var vInset: CGFloat = 8
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea(.all)
            VStack(spacing: Constants.vSpacing) {
                LunaView(
                    isFocused: $isFocused,
                    state: viewModel.lunaState
                )
                ChatView(
                    messages: $viewModel.messages,
                    isFocused: $isFocused
                )
            }
            .padding(.horizontal, Constants.hInset)
            .padding(.top, Constants.vInset)
            .padding(.bottom, Constants.vSpacing)
            
            .safeAreaInset(edge: .bottom, spacing: 0) {
                MessageInputView(
                    state: $viewModel.inputState,
                    isFocused: $isFocused,
                ) {
                    handleSendTapped()
                }
            }
            .padding(.horizontal, Constants.hInset)
            .padding(.vertical, Constants.vInset)
        }
    }
    
    // MARK: - Init
    // TODO: - Should be changed after services implementation
    init() {
        viewModel = MainViewModel()
    }
    
    // MARK: - Private Methods
    
    private func handleSendTapped() {
        viewModel.sendMessage()
    }
    
}

#Preview {
    MainView()
}
