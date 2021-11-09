import Foundation

extension Array {
    
    /// Accesses the element at the specified position safely.
    ///
    /// Parse `nil` will remove the item at the specified index.
    ///
    /// - Parameter index: The position of the element to access safely.
    @inlinable
    public subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            guard indices.contains(index) else { return }
            if let newValue = newValue {
                self[index] = newValue
            } else {
                self.remove(at: index)
            }
        }
    }
}
