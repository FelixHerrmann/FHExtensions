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
    /// The supported formats are hex strings with and without alpha component, the hash symbol is not required and capitalization does not matter.
    ///
    /// Fails if the format is not correct.
    ///
    /// ```swift
    /// let yellow: UIColor? = UIColor(hex: "#ffff00ff")
    /// ```
    ///
    /// - Parameter hex: The hex string to create the color with.
    convenience init?(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if hex.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count == 6 {
            let scanner = Scanner(string: cString)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                let b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
                let a = CGFloat(1)
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
            
        if cString.count == 8 {
            let scanner = Scanner(string: cString)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                let r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                let g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                let b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                let a = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        
        return nil
    }
    
    /// Creates a hex string from the color instance.
    ///
    /// ```swift
    /// let yellow = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
    /// let hexString: String = yellow.createHex(alpha: true)
    /// print(hexString) // "#ffff00ff"
    /// ```
    ///
    /// - Parameters:
    ///   - alpha: Controls whether the hex string contains alpha or not. Default value is `false`.
    ///   - hashSymbol: Controls whether the hex string the hash symbol or not. Default value is `true`.
    /// - Returns: The created hex string.
    func createHex(alpha: Bool = false, hashSymbol: Bool = true) -> String {
        if alpha {
            let r = Int(red * 255) << 24
            let g = Int(green * 255) << 16
            let b = Int(blue * 255) << 8
            let a = Int(self.alpha * 255) << 0
            let rgba: Int = r | g | b | a
            if hashSymbol {
                return NSString(format: "#%08x", rgba) as String
            } else {
                return NSString(format: "%08x", rgba) as String
            }
        } else {
            let r = Int(red * 255) << 16
            let g = Int(green * 255) << 8
            let b = Int(blue * 255) << 0
            let rgb: Int = r | g | b
            if hashSymbol {
                return NSString(format: "#%06x", rgb) as String
            } else {
                return NSString(format: "%06x", rgb) as String
            }
        }
    }
}

#endif
