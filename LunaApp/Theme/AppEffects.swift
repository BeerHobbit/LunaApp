import SwiftUI

enum AppEffects {
    static var standardShadow: some ShapeStyle {
        Color.LunaColors.gray
            .shadow(
                .drop(
                    color: Color.LunaColors.black.opacity(0.35),
                    radius: 0,
                    x: 0,
                    y: 6
                )
            )
    }
}
