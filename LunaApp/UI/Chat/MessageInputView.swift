import SwiftUI

struct MessageInputView: View {
    
    // MARK: - Private Properties
    
    @Binding private var state: InputState
    @FocusState.Binding private var isFocused: Bool
    private let isAnswerLoading: Bool
    private let onSend: () -> Void
    private static let lineLimit: Int = 6
    private var isSendingDisabled: Bool {
        isAnswerLoading || state.isInputEmpty || state.isLimitReached
    }
    private var buttonImageStyle: Color {
        isSendingDisabled
        ? Color.LunaColors.gray
        : Color.LunaColors.black
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: AppTheme.Spacings.xSmall) {
            VStack(alignment: .leading, spacing: 0) {
                if state.isLimitReached {
                    Text(
                        .inputCharacterLimitReached(
                            current: state.input.unicodeScalars.count,
                            limit: state.characterLimit
                        )
                    )
                        .font(AppFont.regular)
                        .foregroundStyle(.red)
                        .padding(.horizontal, AppTheme.Spacings.medium)
                        .padding(.top, AppTheme.Spacings.xSmall)
                }
                TextField(
                    "",
                    text: $state.input,
                    prompt: Text(.inputPlaceholder)
                        .foregroundStyle(Color.LunaColors.gray),
                    axis: .vertical
                )
                .font(AppFont.medium)
                .lineLimit(MessageInputView.lineLimit)
                .padding(AppTheme.Spacings.medium)
                .foregroundStyle(Color.LunaColors.white)
                .focused($isFocused)
            }
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
                .disabled(isSendingDisabled)
            }
        }
        .border(Color.LunaColors.white, width: AppTheme.Components.borderWidth)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.LunaColors.black)
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }
    
    // MARK: - Init
    
    init(
        state: Binding<InputState>,
        isFocused: FocusState<Bool>.Binding,
        isAnswerLoading: Bool,
        onSend: @escaping () -> Void
    ) {
        self._state = state
        self._isFocused = isFocused
        self.isAnswerLoading = isAnswerLoading
        self.onSend = onSend
    }
    
}
