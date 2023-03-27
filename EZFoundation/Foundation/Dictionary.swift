//
//  Dictionary.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/3/27.
//

import Foundation

extension Dictionary {
    
    /// {"key": "value"}
    var prettyPrintedDescription: String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
              let string = String(data: data, encoding: .utf8) else {
            return description
        }
        return string
    }
}
