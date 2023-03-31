//
//  Module.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/3/31.
//

class Module {
    static let name: String = NSStringFromClass(Module.self).components(separatedBy: ".")[0]
    static let bundle: Bundle = .init(path: Bundle(for: Module.self).path(forResource: name, ofType: "bundle")!)!
}

let bundle: Bundle = Module.bundle
