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

public extension UIColor {
    
    /// Creates a color instance from a hex string.
    ///
    /// Fails if the format is not correct.
    /// - Parameter hex: The format must be a # symbol, followed by red, green, blue and alpha in hex format. #ffff00ff is yellow.
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

#endif
