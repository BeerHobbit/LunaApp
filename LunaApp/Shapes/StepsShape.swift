import SwiftUI

struct StepsShape: InsettableShape {
    
    var steps: Int = 3
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        
        guard steps > 0 else { return Path() }
        
        var path = Path()
        let stepSize = rect.width / CGFloat(steps)
        var currentPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.move(to: currentPoint)
        
        for _ in 0..<steps {
            currentPoint.x += stepSize
            path.addLine(to: currentPoint)
            
            currentPoint.y += stepSize
            path.addLine(to: currentPoint)
        }
        
        path.addLine(to: CGPoint(x: rect.minX, y: currentPoint.y))
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
    
}
