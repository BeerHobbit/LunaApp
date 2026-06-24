import SwiftUI

struct MessageInputView: View {
    
    // MARK: - Public Properties
    
    @Binding var state: InputState
    @FocusState.Binding var isFocused: Bool
    let onSend: () -> Void
    
    // MARK: - Private Properties
    
    private let lineLimit = 6
    private var buttonImageStyle: Color {
        state.sendingIsDisabled ? Color.LunaColors.gray : Color.LunaColors.black
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: AppTheme.Spacings.small) {
            TextField(
                "",
                text: $state.input,
                prompt: Text(.inputPlaceholder)
                    .foregroundStyle(Color.LunaColors.gray),
                axis: .vertical
            )
            .font(AppFont.medium)
            .lineLimit(lineLimit)
            .padding(AppTheme.Spacings.medium)
            .foregroundStyle(Color.LunaColors.white)
            .focused($isFocused)
            VStack {
                Spacer(minLength: .zero)
                Button(action: onSend) {
                    Image(.enter)
                        .resizable()
                        .scaledToFit()
                        .padding(AppTheme.Spacings.xSmall)
                }
                .frame(
                    width: AppTheme.Components.sendButtonWidth,
                    height: AppTheme.Components.sendButtonHeight
                )
                .background(Color.LunaColors.white)
                .foregroundStyle(buttonImageStyle)
                .disabled(state.sendingIsDisabled)
            }
        }
        .border(Color.LunaColors.white, width: AppTheme.Components.borderWidth)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.LunaColors.black)
    }
    
}
