#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// Returns the red component that make up the color in the RGB color space.
    ///
    /// Value is between `0.0` and `1.0.
    var red: CGFloat {
        var red: CGFloat = 0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }
    
    /// Returns the green component that make up the color in the RGB color space.
    ///
    /// Value is between `0.0` and `1.0.
    var green: CGFloat {
        var green: CGFloat = 0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return green
    }
    
    /// Returns the blue component that make up the color in the RGB color space.
    ///
    /// Value is between `0.0` and `1.0.
    var blue: CGFloat {
        var blue: CGFloat = 0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return blue
    }
    
    /// Returns the alpha component that make up the color in the RGB color space.
    ///
    /// Value is between `0.0` and `1.0.
    var alpha: CGFloat {
        var alpha: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
    }
}

#endif
