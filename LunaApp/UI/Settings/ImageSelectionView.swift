import SwiftUI

struct ImageSelectionView<ImageType: ImageResourceProviding>: View {
    
    private let title: String?
    private let images: [ImageType]
    @Binding var selected: ImageType
    private let aspectRatio: CGFloat
    private let visibleItems: Int
    private let widthMultiplier: CGFloat
    
    private var stackSpacing: CGFloat {
        AppTheme.Spacings.small
    }
    private let overlayOpacity: Double = 0.3
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacings.small) {
            if let title {
                Text(title)
                    .font(AppFont.medium)
                    .padding(.horizontal, AppTheme.Spacings.large)
            }
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: stackSpacing) {
                        ForEach(images, id: \.rawValue) { image in
                            Image(image.previewImage)
                                .resizable()
                                .aspectRatio(aspectRatio, contentMode: .fit)
                                .containerRelativeFrame(.horizontal) { width, _ in
                                    let count = CGFloat(visibleItems)
                                    let totalSpacing = (count - 1) * stackSpacing
                                    return (width - totalSpacing) / count * widthMultiplier
                                }
                                .overlay {
                                    if image == selected {
                                        selectionOverlay()
                                    }
                                }
                                .onTapGesture {
                                    select(image: image, proxy: proxy)
                                }
                        }
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .contentMargins(.horizontal, AppTheme.Spacings.large, for: .scrollContent)
            }
        }
    }
    
    func selectionOverlay() -> some View {
        ZStack {
            Color.LunaColors.gray
                .opacity(overlayOpacity)
            Image(.check)
                .resizable()
                .padding(AppTheme.Spacings.small)
                .frame(
                    width: AppTheme.Components.buttonSize,
                    height: AppTheme.Components.buttonSize
                )
                .foregroundStyle(Color.LunaColors.white)
        }
    }
    
    init(
        title: String?,
        images: [ImageType],
        selected: Binding<ImageType>,
        aspectRatio: CGFloat,
        visibleItems: Int,
        widthMultiplier: CGFloat
    ) {
        precondition(visibleItems > 0, "visibleItems must be greater than 0")
        precondition(widthMultiplier != 0, "widthMultiplier must not be equal to 0")
        
        self.title = title
        self.images = images
        self._selected = selected
        self.aspectRatio = aspectRatio
        self.visibleItems = visibleItems
        self.widthMultiplier = widthMultiplier
    }
    
    func select(image: ImageType, proxy: ScrollViewProxy) {
        selected = image
        withAnimation(.easeOut(duration: AppTheme.Animations.shortDuration)) {
            proxy.scrollTo(image.rawValue, anchor: .center)
        }
    }
    
}

#Preview {
    @Previewable @State var selected1 = BackgroundImage.retrowaveGrid
    @Previewable @State var selected2 = LunaBackgroundImage.window
    VStack(spacing: 16) {
        ImageSelectionView(
            title: "Обои",
            images: BackgroundImage.allCases,
            selected: $selected1,
            aspectRatio: 1/2,
            visibleItems: 2,
            widthMultiplier: 0.8
        )
        ImageSelectionView(
            title: "Обои Луны",
            images: LunaBackgroundImage.allCases,
            selected: $selected2,
            aspectRatio: 2/1,
            visibleItems: 1,
            widthMultiplier: 0.8
        )
    }
}

