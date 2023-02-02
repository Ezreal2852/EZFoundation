//
//  Extended.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/2.
//

//MARK: - 基于命名空间的拓展

public struct Extension<ExtendedType> {
    
    public private(set) var type: ExtendedType
    
    public init(_ type: ExtendedType) {
        self.type = type
    }
}

public protocol Extended {
    
    associatedtype ExtendedType
    
    static var ez: Extension<ExtendedType>.Type { get set }
    
    var ez: Extension<ExtendedType> { get set }
}

extension Extended {
    
    public static var ez: Extension<Self>.Type {
        get { Extension<Self>.self }
        set {}
    }
    
    public var ez: Extension<Self> {
        get { Extension(self) }
        set {}
    }
}

//MARK: - 测试

extension NSObject: Extended {}

extension Extension where ExtendedType: NSObject {
    
    static func test() {
        
    }
    
    func test() {
        
    }
}

fileprivate func test() {
    
    NSObject.ez.test()
    
    NSObject().ez.test()
}
