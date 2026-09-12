import SwiftUI

struct AppToggleStyle: ToggleStyle {
    
    // MARK: - Private Properties
    
    @State private var isPressed: Bool = false
    private static let gestureDuration: Double = 0.5
    private var scale: Double {
        isPressed ? 1 : 0.9
    }
    private var opacity: Double {
        isPressed ? 0.8 : 1
    }
    
    // MARK: - ToggleStyle
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack {
                Rectangle()
                    .fill(configuration.isOn ? Color.LunaColors.violet : Color.LunaColors.gray)
                    .frame(width: AppTheme.Components.toggleWidth, height: AppTheme.Components.toggleHeight)
                    .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                        Rectangle()
                            .fill(Color.LunaColors.white)
                            .padding(AppTheme.Spacings.xxxSmall)
                            .frame(width: AppTheme.Components.toggleHeight, height: AppTheme.Components.toggleHeight)
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .animation(.default, value: isPressed)
                    }
            }
            .frame(height: AppTheme.Components.buttonSize)
            .contentShape(Rectangle())
            .animation(.easeOut, value: configuration.isOn)
            .onTapGesture {
                configuration.isOn.toggle()
            }
            .onLongPressGesture(minimumDuration: AppToggleStyle.gestureDuration) {
                configuration.isOn.toggle()
            } onPressingChanged: { pressing in
                isPressed = pressing
            }
        }
    }
    
}
