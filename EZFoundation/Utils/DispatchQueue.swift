//
//  DispatchQueue.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/8/28.
//  Copyright © 2020 Ezreal. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    private static var _onceTracker: [String] = []
    
    /// 运行中，仅一次执行，同OC-dispatch_once
    public static func ez_once(_ token: String = UUID().uuidString, execute: () -> Void) {
        
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) { return }
        
        execute()
    }
    
    /// 确保代码在主线程中执行而无需外部判断
    public static func ez_mainAsync(execute work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            main.async(execute: work)
        }
    }
}
