//
//  ObjcAssociatedWeakObject.swift
//  AssociatedObject 关联弱引用对象，唯一，且读写类型一致。

import ObjectiveC

fileprivate typealias AssociatedObjectBlock = (() -> AnyObject?)

fileprivate func objc_getAssociatedWeakObject(_ object: AnyObject, _ key: UnsafeRawPointer) -> AnyObject? {
    let block = objc_getAssociatedObject(object, key) as? AssociatedObjectBlock
    return block?()
}

fileprivate func objc_setAssociatedWeakObject(_ object: AnyObject, _ key: UnsafeRawPointer, _ value: AnyObject?) {
    weak var weakValue = value
    let block: AssociatedObjectBlock? = { weakValue }
    objc_setAssociatedObject(object, key, block, .OBJC_ASSOCIATION_COPY)
}

fileprivate let kWeakObj = malloc(4)! // UnsafeMutableRawPointer!

extension NSObject {
    
    fileprivate var weakObject: AnyObject? {
        set { objc_setAssociatedWeakObject(self, kWeakObj, newValue) }
        get { objc_getAssociatedWeakObject(self, kWeakObj) }
    }
    
    public func setWeakObject<T: AnyObject>(_ object: T?) {
        weakObject = object
    }
    
    public func getWeakObject<T: AnyObject>() -> T? {
        weakObject as? T
    }
}
