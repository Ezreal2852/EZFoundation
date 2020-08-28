//
//  UIApplication.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

public extension UIApplication {
    
    /// 顶层可见控制器
    static var ez_topViewController: UIViewController? {
        var current: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
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
    
    static var ez_keyWindow: UIWindow? {
        if #available(iOS 13.0.0, *) {
            return shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?
                .windows
                .filter({ $0.isKeyWindow })
                .first
        } else {
            return shared.keyWindow
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
}
