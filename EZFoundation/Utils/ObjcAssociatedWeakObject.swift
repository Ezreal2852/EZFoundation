//
//  ObjcAssociatedWeakObject.swift
//  AssociatedObject 弱引用一个对象

import ObjectiveC

public func objc_getAssociatedWeakObject(_ object: AnyObject, _ key: UnsafeRawPointer) -> AnyObject? {
    let block: (() -> AnyObject?)? = objc_getAssociatedObject(object, key) as? (() -> AnyObject?)
    return block != nil ? block?() : nil
}

public func objc_setAssociatedWeakObject(_ object: AnyObject, _ key: UnsafeRawPointer, _ value: AnyObject?) {
    weak var weakValue = value
    let block: (() -> AnyObject?)? = {
        return weakValue
    }
    objc_setAssociatedObject(object, key, block, .OBJC_ASSOCIATION_COPY)
}

fileprivate let kWeakObj = malloc(4)! // UnsafeMutableRawPointer!

fileprivate extension NSObject {
    
    var weakObj: AnyObject? {
        set { objc_setAssociatedWeakObject(self, kWeakObj, newValue) }
        get { objc_getAssociatedWeakObject(self, kWeakObj) }
    }
}
