import SwiftUI

struct SettingsView: View {
    
    @Bindable private var viewModel: SettingsViewModel
    @Environment(\.dismiss) private var dismiss
    private let backgrounds: [BackgroundImage] = BackgroundImage.allCases
    private let lunaBackgrounds: [LunaBackgroundImage] = LunaBackgroundImage.allCases
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Toggle(isOn: $viewModel.settings.shouldSave) {
                        Text("Сохранять сообщения")
                    }
                    .font(AppFont.medium)
                    .foregroundStyle(Color.LunaColors.white)
                    .tint(Color.LunaColors.violet)
                    .padding(.horizontal)
                    
                    ImageSelectionView(
                        title: "Обои",
                        images: backgrounds,
                        selected: $viewModel.settings.background,
                        aspectRatio: 1/2,
                        visibleItems: 2,
                        widthMultiplier: 0.8
                    )
                    ImageSelectionView(
                        title: "Обои Луны",
                        images: lunaBackgrounds,
                        selected: $viewModel.settings.lunaBackground,
                        aspectRatio: 2/1,
                        visibleItems: 1,
                        widthMultiplier: 0.8
                    )
                }
            }
            .safeAreaInset(edge: .bottom, spacing: .zero) {
                VStack(spacing: 0) {
                    Button {
                        viewModel.saveChanges()
                        dismiss()
                    } label: {
                        Text("Сохранить")
                    }
                    .font(AppFont.medium)
                    .tint(Color.LunaColors.black)
                    .disabled(!viewModel.hasChanges)
                    
                    .frame(height: AppTheme.Components.buttonSize)
                    .frame(maxWidth: .infinity)
                    .background(Color.LunaColors.white)
                    .padding(.horizontal, AppTheme.Spacings.large)
                    .padding(.vertical, AppTheme.Spacings.medium)
                }
                .background(Color.LunaColors.darkGray)
            }
            .toolbar {
                toolbarItems()
            }
            .scrollBounceBehavior(.basedOnSize)
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
                .font(AppFont.large)
                .foregroundStyle(Color.LunaColors.white)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
            } label: {
                Image(.exit)
                    .resizable()
                    .scaledToFit()
            }
            .tint(Color.LunaColors.white)
            .padding(AppTheme.Spacings.xSmall)
            .frame(
                width: AppTheme.Components.buttonSize,
                height: AppTheme.Components.buttonSize
            )
        }
    }
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

}

#Preview {
    let container = DependencyContainer()
    SettingsView(viewModel: container.makeSettingsViewModel())
}
