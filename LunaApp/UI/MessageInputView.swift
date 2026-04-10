import SwiftUI

struct MessageInputView: View {
    
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    let onSend: () -> Void
    
    var enterIsDisabled: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            TextField(
                "",
                text: $text,
                prompt: Text("Напиши мне...")
                    .foregroundStyle(Color.LunaColors.gray),
                axis: .vertical
            )
            .font(AppFont.regular)
            .lineLimit(4)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .foregroundStyle(Color.LunaColors.black)
            .focused($isFocused)
            
            VStack {
                Spacer(minLength: 0)
                Button(action: onSend) {
                    Image(.enter)
                        .foregroundStyle(enterIsDisabled ? Color.LunaColors.gray : Color.LunaColors.black )
                }
                .frame(width: 60, height: 36)
                .background(
                    Color.LunaColors.white
                        .shadow(
                            .inner(
                                color: .black.opacity(0.35),
                                radius: 0,
                                x: -4,
                                y: -4
                            )
                        )
                )
                .disabled(enterIsDisabled)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(4)
        .background(
            Color.LunaColors.lightGray
                .shadow(
                    .drop(
                        color: .black.opacity(0.35),
                        radius: 0,
                        x: 0,
                        y: -6
                    )
                )
        )
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }
    
}

#Preview {
    @Previewable @State var text = ""
    @FocusState var isFocused: Bool
    MessageInputView(text: $text, isFocused: $isFocused, onSend: {})
}
