//
//  UINavigationController.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

public extension UINavigationController {
    
    /// 推进一个控制器
    /// - Parameters:
    ///   - viewController: 目标控制器
    ///   - completion: 完成回调
    func ez_pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// 弹出当前控制器
    /// - Parameters:
    ///   - animated: 动画（默认为true）
    ///   - completion: 完成回调
    func ez_popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// 使导航栏控制器的导航栏变透明
    /// - Parameter tint: 着色 (默认白色).
    func ez_makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}
