//
//  UIView.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

// MARK: - 属性

public extension UIView {
    
    /// X轴坐标
    var ez_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// Y轴坐标
    var ez_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// 宽
    var ez_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// 高
    var ez_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// 大小
    var ez_size: CGSize {
        get {
            return frame.size
        }
        set {
            ez_width = newValue.width
            ez_height = newValue.height
        }
    }
    
    /// 边缘颜色
    @IBInspectable var ez_borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// 边缘宽度
    @IBInspectable var ez_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// 圆角半径
    @IBInspectable var ez_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// 阴影颜色
    @IBInspectable var ez_shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// 阴影偏移量
    @IBInspectable var ez_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// 阴影透明度
    @IBInspectable var ez_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// 阴影半径
    @IBInspectable var ez_shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// 当前视图的父控制器
    var ez_parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// 当前视图截屏(支持UIScrollView)
    var ez_snapshot: UIImage? {
        
        if self is UIScrollView {
            let scrollView = self as! UIScrollView
            UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 0)
            defer { UIGraphicsEndImageContext() }
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            let previousFrame = frame
            frame = CGRect(origin: frame.origin, size: scrollView.contentSize)
            layer.render(in: context)
            frame = previousFrame
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - 方法

public extension UIView {
    
    /// 第一响应者
    func ez_firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: self)
        var index = 0
        repeat {
            let view = views[index]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            index += 1
        } while index < views.count
        return nil
    }
    
    /// 添加自定义角落圆角(基于frame)
    /// - Parameters:
    ///   - corners: [UIRectCorner]
    ///   - radius: 半径
    func ez_roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    /// 添加阴影
    /// - Parameters:
    ///   - color: 颜色
    ///   - radius: 半径
    ///   - offset: 偏移量
    ///   - opacity: 透明度
    func ez_addShadow(ofColor color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /// 添加渐变圆角（基于frame）
    func addGradientBorder(opacity: Float, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint, borderWidth: CGFloat, cornerRadius: CGFloat) {
        let frame = self.bounds
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.opacity = opacity
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        let borderInset = borderWidth / 2.0
        let maskFrame = CGRect(x: borderInset, y: borderInset, width: frame.width - borderInset, height: frame.height - borderInset)
        
        let maskLayer = CAShapeLayer()
        maskLayer.lineWidth = borderWidth
        maskLayer.path = UIBezierPath(roundedRect: maskFrame, cornerRadius: cornerRadius).cgPath
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.mask = maskLayer
        
        self.layer.addSublayer(gradientLayer)
    }
}
