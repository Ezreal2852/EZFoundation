//
//  MultiDelegate.swift
//  Common
//
//  Created by 刘嘉豪 on 2021/11/24.
//

import Foundation

fileprivate var kDelegates = ""

/// 多代理
public protocol MultiDelegate {
        
    var delegates: NSHashTable<AnyObject> { get }
    
    func addDelegate(_ delegate: AnyObject)
    func removeDelegate(_ delegate: AnyObject)
}

public extension MultiDelegate {
    
    var delegates: NSHashTable<AnyObject> {
        if let delegates = objc_getAssociatedObject(self, &kDelegates) as? NSHashTable<AnyObject> {
            return delegates
        }
        let delegates = NSHashTable<AnyObject>.weakObjects()
        objc_setAssociatedObject(self, &kDelegates, delegates, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return delegates
    }
    
    func addDelegate(_ delegate: AnyObject) {
        synchronized(delegates) {
            if $0.contains(delegate) {
                print(self, #function, delegate, "重复添加代理！")
                return
            }
            $0.add(delegate)
        }
    }
    
    /// 正常情况下，delegate不被引用，会自动释放(仅需主动移除代理的场景，如单例)，所以无需调用，但是释放后，delegates.count不会正确更新
    func removeDelegate(_ delegate: AnyObject) {
        synchronized(delegates) {
            guard $0.contains(delegate) else {
                print(self, #function, delegate, $0, "重复移除代理！")
                return
            }
            $0.remove(delegate)
        }
    }
}
