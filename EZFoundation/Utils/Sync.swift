//
//  Sync.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2022/8/26.
//

import ObjectiveC

/// 递归锁，同OC-@synchronized
/// - Parameters:
///   - obj: 被锁定的对象
///   - `do`: 执行安全访问操作
public func synchronized(_ obj: Any, `do`: (_ obj: Any) -> Void) {
    objc_sync_enter(obj)
    `do`(obj)
    objc_sync_exit(obj)
}
