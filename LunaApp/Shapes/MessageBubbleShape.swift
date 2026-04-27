import SwiftUI


struct MessageBubbleShape: InsettableShape {
    
    enum Direction {
        case left
        case right
    }
    
    var direction: Direction
    var tailSize: CGFloat = 9
    var tailSteps: Int = 3
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        
        var path = Path()
        
        let mainRect: CGRect
        let tail: Path
        
        switch direction {
        case .right:
            mainRect = CGRect(
                x: rect.minX,
                y: rect.minY,
                width: rect.width - tailSize,
                height: rect.height
            )
            let tailRect = CGRect(
                x: rect.maxX - tailSize,
                y: rect.maxY - tailSize,
                width: tailSize,
                height: tailSize
            )
            tail = StepsShape(steps: tailSteps)
                .path(in: tailRect)
        case .left:
            mainRect = CGRect(
                x: rect.minX + tailSize,
                y: rect.minY,
                width: rect.width - tailSize,
                height: rect.height
            )
            let tailRect = CGRect(
                x: rect.minX,
                y: rect.maxY - tailSize,
                width: tailSize,
                height: tailSize
            )
            tail = StepsShape(steps: tailSteps)
                .path(in: tailRect)
                .flippedHorizontally(in: tailRect)
        }
        
        path.addRect(mainRect)
        path.addPath(tail)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
    
}
