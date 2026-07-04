import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var shouldSave: Bool = true
    @State var hasChanges: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: $shouldSave) {
                    Text("Сохранять сообщения")
                }
                .font(AppFont.medium)
                .foregroundStyle(Color.LunaColors.white)
                .tint(Color.LunaColors.violet)
                
                
                
                Spacer()
                Button {
                    saveChanges()
                } label: {
                    Text("Сохранить")
                }
                .font(AppFont.medium)
                .tint(Color.LunaColors.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Color.LunaColors.white
                )
                .disabled(!hasChanges)
            }
            .toolbar {
                toolbarItems()
            }
            .padding()
            .preferredColorScheme(.dark)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.LunaColors.darkGray
                    .ignoresSafeArea()
            )
        }
    }
    
    @ToolbarContentBuilder
    private func toolbarItems() -> some ToolbarContent {
        ToolbarItem(placement: .title) {
            Text(.settingsTitle)
                .font(AppFont.medium)
                .foregroundStyle(Color.LunaColors.white)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(.exit)
                    .resizable()
                    .scaledToFit()
                    .padding(AppTheme.Spacings.xxSmall)
            }
            .tint(Color.LunaColors.white)
            .frame(
                width: AppTheme.Components.buttonSize,
                height: AppTheme.Components.buttonSize
            )
        }
    }
    
    private func saveChanges() {
        
    }
    
}

#Preview {
    SettingsView()
}
