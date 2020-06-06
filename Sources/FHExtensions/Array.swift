//
//  File.swift
//  
//
//  Created by FHRApps on 06.06.20.
//

import Foundation

public extension Array {
    /// Accesses the element at the specified position safely.
    /// - Parameter index: The position of the element to access safely.
    @inlinable subscript(safe index: Index) -> Element? {
        if index >= startIndex && index < endIndex {
            return self[index]
        }
        return nil
    }
}
