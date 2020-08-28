//
//  EZMetric.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/07/25.
//  Copyright © 2020 EZ. All rights reserved.
//

extension UIViewController: EZMetric {}

extension UIView: EZMetric {}

public protocol EZMetric {
    
    /// 安全边距
    static var ez_safeAreaInsets: UIEdgeInsets { get }
    /// 顶部安全距离
    static var ez_safeTopInset: CGFloat { get }
    /// 底部安全距离
    static var ez_safeBottomInset: CGFloat { get }
    /// 状态栏高度
    static var ez_statusBarHeight: CGFloat { get }
    /// 导航栏高度
    static var ez_navigationBarHeight: CGFloat { get }
    /// 状态栏+导航栏高度
    static var ez_statusNavigationBarHeight: CGFloat { get }
    /// 工具栏高度
    static var ez_tabBarHeight: CGFloat { get }
    /// 工具栏高度(含安全边距)
    static var ez_safeTabBarHeight: CGFloat { get }
    /// 屏幕高度
    static var ez_screenHeight: CGFloat { get }
    /// 屏幕宽度
    static var ez_screenWidth: CGFloat { get }
    /// 单位像素高度
    static var ez_pixel: CGFloat { get }
    
    /// 安全边距
    var ez_safeAreaInsets: UIEdgeInsets { get }
    /// 顶部安全距离
    var ez_safeTopInset: CGFloat { get }
     /// 底部安全距离
    var ez_safeBottomInset: CGFloat { get }
    /// 状态栏高度
    var ez_statusBarHeight: CGFloat { get }
    /// 导航栏高度
    var ez_navigationBarHeight: CGFloat { get }
    /// 状态栏+导航栏高度
    var ez_statusNavigationBarHeight: CGFloat { get }
    /// 工具栏高度
    var ez_tabBarHeight: CGFloat { get }
    /// 工具栏高度(含安全边距)
    var ez_safeTabBarHeight: CGFloat { get }
    /// 屏幕高度
    var ez_screenHeight: CGFloat { get }
    /// 屏幕宽度
    var ez_screenWidth: CGFloat { get }
    /// 单位像素高度
    var ez_pixel: CGFloat { get }
}

public extension EZMetric {
    
    static var ez_safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0.0, *) {
            // FIXME: iOS 13 Scene bug
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
    static var ez_safeTopInset: CGFloat { ez_safeAreaInsets.top }
    static var ez_safeBottomInset: CGFloat { ez_safeAreaInsets.bottom }
    static var ez_statusBarHeight: CGFloat { UIApplication.shared.statusBarFrame.height }
    static var ez_navigationBarHeight: CGFloat { 44 }
    static var ez_statusNavigationBarHeight: CGFloat { ez_statusBarHeight + ez_navigationBarHeight }
    static var ez_tabBarHeight: CGFloat { 49 }
    static var ez_safeTabBarHeight: CGFloat { ez_tabBarHeight + ez_safeBottomInset }
    static var ez_screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    static var ez_screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    static var ez_pixel: CGFloat { 1.0 / UIScreen.main.scale }
    
    var ez_safeAreaInsets: UIEdgeInsets { Self.ez_safeAreaInsets }
    var ez_safeTopInset: CGFloat { Self.ez_safeTopInset }
    var ez_safeBottomInset: CGFloat { Self.ez_safeBottomInset }
    var ez_statusBarHeight: CGFloat { Self.ez_statusBarHeight }
    var ez_navigationBarHeight: CGFloat { Self.ez_navigationBarHeight }
    var ez_statusNavigationBarHeight: CGFloat { Self.ez_statusNavigationBarHeight }
    var ez_tabBarHeight: CGFloat { Self.ez_tabBarHeight }
    var ez_safeTabBarHeight: CGFloat { Self.ez_safeTabBarHeight }
    var ez_screenHeight: CGFloat { Self.ez_screenHeight }
    var ez_screenWidth: CGFloat { Self.ez_screenWidth }
    var ez_pixel: CGFloat { Self.ez_pixel }
}
