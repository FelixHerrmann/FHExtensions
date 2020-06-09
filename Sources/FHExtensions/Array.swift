import Foundation

public extension Array {
    /// Accesses the element at the specified position safely.
    /// - Parameter index: The position of the element to access safely.
    @inlinable subscript(safe index: Index) -> Element? {
        guard index >= startIndex && index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
