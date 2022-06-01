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
    
    public static func ez_once(_ token: String = UUID().uuidString, execute: () -> Void) {
        
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) { return }
        
        execute()
    }
}
