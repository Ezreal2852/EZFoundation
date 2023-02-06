//
//  Sync.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2022/8/26.
//

import ObjectiveC

/// 递归互斥锁，同OC-@synchronized
/// - Parameters:
///   - obj: 绑定锁的对象，但不一定需要访问obj，但需标识，用于创建锁和访问锁。
///   - `do`:  执行安全访问操作
public func synchronized<T>(_ obj: T, `do`: (_ obj: T) -> Void) {
    objc_sync_enter(obj)
    `do`(obj)
    objc_sync_exit(obj)
}
