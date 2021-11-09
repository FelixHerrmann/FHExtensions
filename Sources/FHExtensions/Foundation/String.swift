import Foundation

extension String {
    
    /// A copy of the string where the first letter is capitalized.
    public var capitalizedFirst: String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }
}
