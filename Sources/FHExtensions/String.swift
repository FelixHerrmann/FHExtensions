import Foundation

public extension String {
    
    /// A copy of the string where the first letter is capitalized.
    var capitalizedFirst: String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
