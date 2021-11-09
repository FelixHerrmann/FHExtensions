#if canImport(CoreGraphics)
import CoreGraphics

extension CGRect {
    
    /// The x-coordinate of the rectangle’s origin.
    public var x: CGFloat {
        get {
            return origin.x
        }
        set {
            self = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    
    /// The y-coordinate of the rectangle’s origin.
    public var y: CGFloat {
        get {
            return origin.y
        }
        set {
            self = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    
    /// The top-coordinate of the rectangle’s origin.
    public var top: CGFloat {
        get {
            return origin.y
        }
        set {
            y = newValue
        }
    }
    
    /// The bottom-coordinate of the rectangle’s origin.
    public var bottom: CGFloat {
        get {
            return origin.y + height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    /// The left-coordinate of the rectangle’s origin.
    public var left: CGFloat {
        get {
            return origin.x
        }
        set {
            x = newValue
        }
    }
    
    /// The right-coordinate of the rectangle’s origin.
    public var right: CGFloat {
        get {
            return origin.x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    /// The center-coordinate of the rectangle’s origin.
    public var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
}

#endif // canImport(CoreGraphics)
