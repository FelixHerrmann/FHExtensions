import Foundation

public extension Array {
    
    /// Accesses the element at the specified position safely.
    /// - Parameter index: The position of the element to access safely.
    @inlinable subscript(safe index: Index) -> Element? {
        get {
            guard index >= startIndex && index < endIndex else {
                return nil
            }
            
            return self[index]
        }
        set {
            guard let newValue = newValue, index >= startIndex && index < endIndex else {
                return
            }
            
            self[index] = newValue
        }
    }
}
