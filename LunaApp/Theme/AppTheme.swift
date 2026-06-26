import SwiftUI

enum AppTheme {
    enum Spacings {
        static let xxSmall: CGFloat = 3
        static let xSmall: CGFloat = 6
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        
        static let messageSpacer: CGFloat = 60
    }
    
    enum Components {
        static let borderWidth: CGFloat = 3
        
        static let tailSize: CGFloat = 8
        
        static let buttonSize: CGFloat = 44
        
        static let sendButtonHeight: CGFloat = 44
        static let sendButtonWidth: CGFloat = 60
        
        static let lunaViewHeight: CGFloat = 170
    }
    
    enum Animations {
        static let delay: Double = 0.15
        static let shortDuration: Double = 0.15
        static let duration: Double = 0.3
    }
    
    enum Effects {
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
    
    enum SystemIcons {
        static let copy: String = "document.on.document"
        static let delete: String = "trash"
    }
    
}
