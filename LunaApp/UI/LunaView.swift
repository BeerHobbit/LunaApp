import SwiftUI

struct LunaView: View {
    
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        Image(.lunaViewBackground)
            .resizable()
            .frame(height: 170)
            .border(Color.LunaColors.violet, width: 3)
            .background(
                Color.LunaColors.gray.shadow(
                    .drop(
                        color: .black.opacity(0.35),
                        radius: 0,
                        x: 0,
                        y: 6
                    )
                )
            )
            .zIndex(1)
            .onTapGesture {
                isFocused = false
            }
    }
    
}

#Preview {
    @FocusState var isFocused: Bool
    LunaView(isFocused: $isFocused)
}
