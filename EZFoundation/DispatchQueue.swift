//
//  DispatchQueue.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/8/28.
//  Copyright © 2020 Ezreal. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    
    private static var _onceTracker: [String] = []
    
    class func ez_once(_ token: String, execute: () -> Void) {
        
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) { return }
        
        execute()
    }
}
