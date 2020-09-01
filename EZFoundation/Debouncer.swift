//
//  Debouncer.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/9/1.
//  Copyright © 2020 Ezreal. All rights reserved.
//

import Foundation

public final class Debouncer {
    
    let interval: TimeInterval
    let excute: () -> Void
    
    private weak var timer: Timer?
    
    /// 防抖器
    /// - Parameters:
    ///   - interval: 时间间隔（两次fire最小时间间隔）
    ///   - excute: 执行闭包
    /// - 第一次调用excute()仍会有延迟，若需立即excute()，可调用fireExcute()
    public init(_ interval: TimeInterval, excute: @escaping () -> Void) {
        self.interval = interval
        self.excute = excute
    }
}

public extension Debouncer {
    
    func fire() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(fireExcute), userInfo: nil, repeats: false)
    }
    
    @objc func fireExcute() { excute() }
}
