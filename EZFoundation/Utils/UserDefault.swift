//
//  UserDefault.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2022/8/24.
//

import Foundation

/**
 ```
 @UserDefault("key") var myInt Int?
 ```
 */
/// Save Objects in UserDefaults.standard with Property wrapper syntax
@propertyWrapper
public struct UserDefault<T> {
    
    /// Key
    public let key: String
    
    /// Get the value if it existes
    public var wrappedValue: T? {
        get { return UserDefaults.standard.object(forKey: key) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    /// Create a new Default with Key
    /// - Parameter key: String key
    public init(_ key: String) { self.key = key }
}

//MARK: - 基于@propertyWrapper使用第三方的实践

#if canImport(DefaultsKit)

/// pod 'DefaultsKit', '~> 0.2.0' # https://github.com/nmdias/DefaultsKit
@_exported import DefaultsKit

//MARK: 统一定义 UserDefaults.keys

extension DefaultsKey {
    /// 测试用，仅做演示
    static let testKey = Key<String>("testKey")
}

//MARK: 包装器，作为var使用

@propertyWrapper
public struct DefaultsVar<T: Codable> {
    
    public let key: Key<T>
    
    public var wrappedValue:T? {
        get { Defaults.shared.get(for: key) }
        set { newValue == nil ? Defaults.shared.clear(key) : Defaults.shared.set(newValue!, for: key) }
    }
    
    public init(_ key: Key<T>) { self.key = key }
}

//MARK: ⬇️演示使用代码

fileprivate func testDefaultsKey() {
    // 直接使用
    Defaults.shared.set("test value", for: .testKey)
    _ = Defaults.shared.get(for: .testKey)
    
    // 作为成员变量使用
    TestDefaultsVar.testValue = "testValue"
    _ = TestDefaultsVar.testValue
}

fileprivate struct TestDefaultsVar {
    @DefaultsVar(.testKey) static var testValue
}

#endif
