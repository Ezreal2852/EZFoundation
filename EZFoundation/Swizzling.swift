//
//  Swizzling.swift
//  iOS13Demo
//
//  Created by Ezreal on 2020/8/28.
//  Copyright © 2020 Ezreal. All rights reserved.
//

import Foundation

public func ez_swizzle(original: (cls: AnyClass, sel: Selector), swizzled: (cls: AnyClass, sel: Selector)) {
    
    guard let originalMethod = class_getInstanceMethod(original.cls, original.sel),
        let swizzledMethod = class_getInstanceMethod(swizzled.cls, swizzled.sel) else { return }
    
    if class_addMethod(original.cls, swizzled.sel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)) {
        class_replaceMethod(original.cls, original.sel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
