//
//  UIApplication.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

public extension UIApplication {
    
    /// 主窗口（适配iOS13多场景）
    static var ez_keyWindow: UIWindow? {
        if #available(iOS 13.0.0, *) {
            return UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    /// 顶层可见控制器
    static var ez_topViewController: UIViewController? {
        var current: UIViewController? = ez_keyWindow?.rootViewController
        while true {
            if let tab = current as? UITabBarController {
                current = tab.selectedViewController
            } else if let nav = current as? UINavigationController {
                current = nav.visibleViewController
            } else if let presented = current?.presentedViewController {
                current = presented
            } else {
                return current
            }
        }
    }
    
    /// APP名称
    static var ez_bundleName: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    /// APP版本号
    static var ez_bundleVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// APP构建号
    static var ez_bundleBuild: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    /// 挂起（进入后台）
    static func suspend() {
        DispatchQueue.main.async {
            let selector = #selector(NSXPCConnection.suspend)
            if shared.responds(to: selector) {
                shared.perform(selector)
            }
        }
    }
}
