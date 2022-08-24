//
//  Array.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2022/8/16.
//

import Foundation

//MARK: - 去重，但是有序（如果直接通过Array(Set(self))，会乱序）

extension Array where Element : Hashable {
    
    public mutating func removeDuplicated() {
        var dict = [Element: Any]()
        self = self.filter({
            dict.updateValue($0, forKey: $0) == nil
        })
    }
    
    public func removedDuplicated() -> Array {
        var dict = [Element: Any]()
        return self.filter({
            dict.updateValue($0, forKey: $0) == nil
        })
    }
}
