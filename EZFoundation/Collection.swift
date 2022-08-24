//
//  Collection.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2022/8/24.
//

import Foundation

extension Collection {
    
    /// Safe indexing.
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    /// ref: https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
    ///
    /// - Parameter index: The index used to retrieve a value / an object.
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
