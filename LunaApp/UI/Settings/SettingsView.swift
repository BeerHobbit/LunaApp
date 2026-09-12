import SwiftUI

struct SettingsView: View {
    
    // MARK: - Private Properties
    
    @Bindable private var viewModel: SettingsViewModel
    @Environment(\.dismiss) private var dismiss
    private let backgrounds: [BackgroundImage] = BackgroundImage.allCases
    private let lunaBackgrounds: [LunaBackgroundImage] = LunaBackgroundImage.allCases
    private static let bgRatio: CGFloat = 1/2
    private static let bgItems: Int = 2
    private static let lunaBgRatio: CGFloat = 2/1
    private static let lunaBgItems: Int = 1
    private static let widthMultiplier: CGFloat = 0.8
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppTheme.Spacings.large) {
                    Toggle(isOn: $viewModel.settings.shouldSave) {
                        Text(.settingsSaveMessages)
                    }
                    .toggleStyle(AppToggleStyle())
                    .font(AppFont.medium)
                    .padding(.horizontal, AppTheme.Spacings.large)
                    
                    ImageSelectionView(
                        title: String(localized: .settingsWallpapers),
                        images: backgrounds,
                        selected: $viewModel.settings.background,
                        aspectRatio: SettingsView.bgRatio,
                        visibleItems: SettingsView.bgItems,
                        widthMultiplier: SettingsView.widthMultiplier
                    )
                    ImageSelectionView(
                        title: String(localized: .settingsLunaWallpapers),
                        images: lunaBackgrounds,
                        selected: $viewModel.settings.lunaBackground,
                        aspectRatio: SettingsView.lunaBgRatio,
                        visibleItems: SettingsView.lunaBgItems,
                        widthMultiplier: SettingsView.widthMultiplier
                    )
                }
            }
            .safeAreaInset(edge: .bottom, spacing: .zero) {
                VStack(spacing: .zero) {
                    Button {
                        viewModel.saveChanges()
                        dismiss()
                    } label: {
                        Text(.settingsSave)
                    }
                    .disabled(!viewModel.hasChanges)
                    .font(AppFont.medium)
                    .tint(Color.LunaColors.black)
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
    
    // MARK: - Views
    
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
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
}

#Preview {
    let container = DependencyContainer()
    SettingsView(viewModel: container.makeSettingsViewModel())
}
