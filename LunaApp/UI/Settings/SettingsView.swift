import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: SettingsViewModel
    private let backgrounds: [BackgroundImage] = BackgroundImage.allCases
    private let lunaBackgrounds: [LunaBackgroundImage] = LunaBackgroundImage.allCases
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Toggle(isOn: $viewModel.settings.shouldSave) {
                    Text("Сохранять сообщения")
                }
                .font(AppFont.medium)
                .foregroundStyle(Color.LunaColors.white)
                .tint(Color.LunaColors.violet)
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Обои")
                        .font(AppFont.medium)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .top) {
                            ForEach(backgrounds, id: \.rawValue) { background in
                                Image(background.previewImage)
                                    .resizable()
                                    .overlay {
                                        if background == viewModel.settings.background {
                                            ZStack {
                                                Color.LunaColors.darkGray
                                                    .opacity(0.5)
                                                Image(.check)
                                                    .resizable()
                                                    .padding(8)
                                                    .frame(width: 44, height: 44)
                                            }
                                        }
                                    }
                                    .frame(width: 120, height: 200)
                                    .onTapGesture {
                                        viewModel.settings.background = background
                                    }
                            }
                        }
                    }
                    .contentMargins(.horizontal, 16, for: .scrollContent)
                    .frame(height: 200)
                }
                
                VStack(alignment: .leading) {
                    Text("Обои Луны")
                        .font(AppFont.medium)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .top) {
                            ForEach(lunaBackgrounds, id: \.rawValue) { background in
                                Image(background.previewImage)
                                    .resizable()
                                    .overlay {
                                        if background == viewModel.settings.lunaBackground {
                                            ZStack {
                                                Color.LunaColors.darkGray
                                                    .opacity(0.5)
                                                Image(.check)
                                                    .resizable()
                                                    .padding(8)
                                                    .frame(width: 44, height: 44)
                                            }
                                        }
                                    }
                                    .frame(width: 200, height: 120)
                                    .onTapGesture {
                                        viewModel.settings.lunaBackground = background
                                    }
                            }
                        }
                    }
                    .contentMargins(.horizontal, 16, for: .scrollContent)
                    .frame(height: 120)
                }
                
                Spacer()
                Button {
                    viewModel.saveChanges()
                    dismiss()
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
                .disabled(!viewModel.hasChanges)
                .padding()
            }
            .toolbar {
                toolbarItems()
            }
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
