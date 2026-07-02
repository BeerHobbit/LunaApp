import SwiftUI

struct BubbleShape: InsettableShape {
    
    // MARK: - Types
    
    enum Direction {
        case left
        case right
    }
    
    // MARK: - Public Properties
    
    let direction: Direction
    var tailSize: CGFloat = 8
    var tailSteps: Int = 4
    var insetAmount: CGFloat = 0
    
    // MARK: - InsettableShape
    
    func path(in rect: CGRect) -> Path {
        switch direction {
        case .left: leftDirectionPath(in: rect)
        case .right: rightDirectionPath(in: rect)
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.insetAmount += amount
        return copy
    }
    
    // MARK: - Private Methods
    
    private func leftDirectionPath(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        guard tailSteps > 0 else { return Path() }
        
        var path = Path()
        let stepSize = tailSize / CGFloat(tailSteps)
        var currentPoint = CGPoint(x: rect.minX, y: rect.maxY)
        path.move(to: currentPoint)
        
        for _ in 0..<tailSteps {
            currentPoint.x += stepSize
            path.addLine(to: currentPoint)
            currentPoint.y -= stepSize
            path.addLine(to: currentPoint)
        }
        
        path.addLines([
            currentPoint,
            CGPoint(x: currentPoint.x, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.maxY),
            CGPoint(x: rect.minX, y: rect.maxY)
        ])
        
        path.closeSubpath()
        
        return path
    }
    
    private func rightDirectionPath(in rect: CGRect) -> Path {
        leftDirectionPath(in: rect)
            .flippedHorizontally(in: rect)
    }
    
}
