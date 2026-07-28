import SwiftUI

struct ImageSelectionView<ImageType: ImageResourceProviding>:
    View {
    private let title: String?
    private let images: [ImageType]
    @Binding var selected: ImageType
    private let aspectRatio: CGFloat
    private let visibleItems: Int
    private let widthMultiplier: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title {
                Text(title)
                    .font(AppFont.medium)
                    .padding(.horizontal)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .bottom, spacing: 8) {
                    ForEach(images, id: \.rawValue) { image in
                        Image(image.previewImage)
                            .resizable()
                            .aspectRatio(aspectRatio, contentMode: .fit)
                            .containerRelativeFrame(.horizontal) { width, _ in
                                width / CGFloat(visibleItems) * widthMultiplier
                            }
                            .overlay {
                                if image == selected {
                                    ZStack {
                                        Color.LunaColors.darkGray
                                            .opacity(0.5)
                                        Image(.check)
                                            .resizable()
                                            .padding(8)
                                            .frame(width: 44, height: 44)
                                            .foregroundStyle(Color.LunaColors.white)
                                    }
                                }
                            }
                            .onTapGesture {
                                selected = image
                            }
                        
                    }
                }
            }
            
            .contentMargins(.horizontal, 16, for: .scrollContent)
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
    
}

#Preview {
    @Previewable @State var selected1 = BackgroundImage.retrowaveGrid
    @Previewable @State var selected2 = LunaBackgroundImage.window
    VStack(spacing: 16) {
        ImageSelectionView(
            title: "Обои",
            images: BackgroundImage.allCases,
            selected: $selected1,
            aspectRatio: 2/1,
            visibleItems: 1,
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

