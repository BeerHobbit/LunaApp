import SwiftUI

extension Path {
    func flippedHorizontally(in rect: CGRect) -> Path {
        let transform = CGAffineTransform(scaleX: -1, y: 1)
            .translatedBy(x: -(rect.minX + rect.maxX), y: 0)
        return self.applying(transform)
    }
}

