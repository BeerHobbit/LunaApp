import SwiftUI

struct MessageInputView: View {
    
    // MARK: - Bindings
    
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    // MARK: - Public Properties
    
    let enterIsDisabled: Bool
    let onSend: () -> Void
    
    // MARK: - Constants
    
    private enum Constants {
        enum MainHStack {
            static let spacing: CGFloat = 8
            static let insets: CGFloat = 4
            
            static let shadowOpacity: Double = 0.35
            static let shadowRadius: CGFloat = 0
            static let shadowXOffset: CGFloat = 0
            static let shadowYOffset: CGFloat = -6
        }
        
        enum TextField {
            static let lineLimit: Int = 4
            static let hInset: CGFloat = 10
            static let vInset: CGFloat = 4
        }
        
        enum Button {
            static let width: CGFloat = 60
            static let height: CGFloat = 36
            
            static let shadowOpacity: Double = 0.35
            static let shadowRadius: CGFloat = 0
            static let shadowXOffset: CGFloat = -4
            static let shadowYOffset: CGFloat = -4
        }
    }
    
    // MARK: - Private Properties
    
    private var mainHStackStyle: some ShapeStyle {
        Color.LunaColors.lightGray
            .shadow(
                .drop(
                    color: .black.opacity(Constants.MainHStack.shadowOpacity),
                    radius: Constants.MainHStack.shadowRadius,
                    x: Constants.MainHStack.shadowXOffset,
                    y: Constants.MainHStack.shadowYOffset
                )
            )
    }
    
    private var buttonStyle: some ShapeStyle {
        Color.LunaColors.white
            .shadow(
                .inner(
                    color: .black.opacity(Constants.Button.shadowOpacity),
                    radius: Constants.Button.shadowRadius,
                    x: Constants.Button.shadowXOffset,
                    y: Constants.Button.shadowYOffset
                )
            )
    }
    
    private var buttonImageStyle: Color {
        enterIsDisabled ? Color.LunaColors.gray : Color.LunaColors.black
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: Constants.MainHStack.spacing) {
            TextField(
                "",
                text: $text,
                prompt: Text("Напиши мне...")
                    .foregroundStyle(Color.LunaColors.gray),
                axis: .vertical
            )
            .font(AppFont.regular)
            .lineLimit(Constants.TextField.lineLimit)
            .padding(.horizontal, Constants.TextField.hInset)
            .padding(.vertical, Constants.TextField.vInset)
            .foregroundStyle(Color.LunaColors.black)
            .focused($isFocused)
            
            VStack {
                Spacer(minLength: 0)
                Button(action: onSend) {
                    Image(.enter)
                        .foregroundStyle(buttonImageStyle)
                }
                .frame(width: Constants.Button.width, height: Constants.Button.height)
                .background(buttonStyle)
                .disabled(enterIsDisabled)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(Constants.MainHStack.insets)
        .background(mainHStackStyle)
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }
    
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @State var isDisabled = false
    @FocusState var isFocused: Bool
    
    MessageInputView(
        text: $text,
        isFocused: $isFocused,
        enterIsDisabled: isDisabled,
        onSend: {}
    )
}
