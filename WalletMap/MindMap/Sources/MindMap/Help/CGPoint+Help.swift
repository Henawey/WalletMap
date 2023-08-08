/// Copyright (c) 2020 Razeware LLC

import CoreGraphics

extension CGPoint {
    public func translatedBy(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
}

extension CGPoint {
    public func alignCenterInParent(_ parent: CGSize) -> CGPoint {
        let x = parent.width/2 + self.x
        let y = parent.height/2 + self.y
        return CGPoint(x: x, y: y)
    }
    
    public func scaledFrom(_ factor: CGFloat) -> CGPoint {
        return CGPoint(
            x: self.x * factor,
            y: self.y * factor)
    }
}

public extension CGSize {
    func scaledDownTo(_ factor: CGFloat) -> CGSize {
        return CGSize(width: width/factor, height: height/factor)
    }
    
    var length: CGFloat {
        return sqrt(pow(width, 2) + pow(height, 2))
    }
    
    var inverted: CGSize {
        return CGSize(width: -width, height: -height)
    }
}
