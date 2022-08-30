//
//  UIConvenienceInit.swift
//  Common
//
//  Created by Ezreal on 2019/11/11.
//  Copyright © 2019 EZ. All rights reserved.
//  通过 style: font&color 设计统一构造器来统一风格，精简UI init代码
//  所有属性默认都为可选且默认值为nil，所有数组全部默认为[]

public extension UIView {
    
    func ez_backgroundColor(_ value: UIColor?) -> Self {
        backgroundColor = value
        return self
    }
    
    func ez_cornerRadius(_ value: CGFloat) -> Self {
        ez_cornerRadius = value
        return self
    }
    
    func ez_borderWidth(_ value: CGFloat) -> Self {
        ez_borderWidth = value
        return self
    }
    
    func ez_borderColor(_ value: UIColor?) -> Self {
        ez_borderColor = value
        return self
    }
    
    func ez_shadowColor(_ value: UIColor?) -> Self {
        ez_shadowColor = value
        return self
    }
    
    func ez_shadowOffset(_ value: CGSize) -> Self {
        ez_shadowOffset = value
        return self
    }
    
    func ez_shadowOpacity(_ value: Float) -> Self {
        ez_shadowOpacity = value
        return self
    }
    
    func ez_shadowRadius(_ value: CGFloat) -> Self {
        ez_shadowRadius = value
        return self
    }
}

public extension UILabel {
    
    convenience init(font: UIFont? = nil,
                     textColor: UIColor? = nil,
                     text: String? = nil,
                     textAlignment: NSTextAlignment = .natural,
                     numberOfLines: Int = 1) {
        
        self.init()
        
        self.text = text
        if let font = font { self.font = font }
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}

public extension UIButton {
    
    convenience init(font: UIFont? = nil,
                     targetAction:(Any?, Selector)? = nil,
                     titleStates: (String?, UIControl.State)...,
                     titleColorStates: (UIColor?, UIControl.State)...,
                     imageStates: (UIImage?, UIControl.State)...,
                     backgroundImageStates: (UIImage?, UIControl.State)...) {
        
        self.init()
        
        if let font = font { self.titleLabel?.font = font }
        if let targetAction = targetAction { self.addTarget(targetAction.0, action: targetAction.1, for: .touchUpInside) }
        
        titleStates.forEach { self.setTitle($0.0, for: $0.1) }
        titleColorStates.forEach { self.setTitleColor($0.0, for: $0.1) }
        imageStates.forEach { self.setImage($0.0, for: $0.1) }
        backgroundImageStates.forEach { self.setBackgroundImage($0.0, for: $0.1) }
    }
}

public extension UITextField {
    
    convenience init(font: UIFont? = nil,
                     text: String? = nil,
                     textColor: UIColor? = nil,
                     placeholder: String? = nil,
                     placeholderColor: UIColor? = nil,
                     delegate: UITextFieldDelegate? = nil) {
        
        self.init()
        
        self.font = font
        self.text = text
        self.textColor = textColor
        self.delegate = delegate
        
        if let placeholder = placeholder, let placeholderColor = placeholderColor {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
        }
    }
}

public extension EZTextView {
    
    convenience init(font: UIFont? = nil,
                     text: String? = nil,
                     textColor: UIColor? = nil,
                     placeholder: String? = nil,
                     placeholderColor: UIColor? = nil,
                     delegate: UITextViewDelegate? = nil) {
        
        self.init()
        
        self.textColor = textColor
        self.delegate = delegate
        
        defer {/// 触发属性的didSet
            if let font = font { self.font = font }
            if let text = text { self.text = text }
            if let placeholder = placeholder { self.placeholder = placeholder }
            if let placeholderColor = placeholderColor { self.placeholderColor = placeholderColor }
        }
    }
}

public extension UITableView {
    
    convenience init(style: UITableView.Style = .plain,
                     dataSource: UITableViewDataSource? = nil,
                     delegate: UITableViewDelegate? = nil,
                     registerCells: (AnyClass?, String)...,
                     registerViews: (AnyClass?, String)...) {
        
        self.init(frame: .zero, style: style)
        
        self.backgroundColor = .white
        self.separatorStyle = .none
        
        self.dataSource = dataSource
        self.delegate = delegate
        
        registerCells.forEach { self.register($0.0, forCellReuseIdentifier: $0.1) }
        registerViews.forEach { self.register($0.0, forHeaderFooterViewReuseIdentifier: $0.1) }
    }
}

public extension UICollectionViewFlowLayout {
    
    convenience init(minimumLineSpacing: CGFloat,
                     minimumInteritemSpacing: CGFloat,
                     itemSize: CGSize = UICollectionViewFlowLayout.automaticSize,
                     estimatedItemSize: CGSize = .zero,
                     scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        
        self.init()
        
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.itemSize = itemSize
        self.estimatedItemSize = estimatedItemSize
        self.scrollDirection = scrollDirection
    }
}

public extension UICollectionView {
    
    /// 集合视图便利构造
    /// - Parameters:
    ///   - layout: 布局
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registerCells: [(继承UICollectionCell的类?, 复用标识)]
    ///   - registerViews: [(继承UICollectionReusableView的类?, UICollectionView.elementKindSectionHeader/elementKindSectionFooter, 复用标识)]]
    convenience init(layout: UICollectionViewFlowLayout,
                     delegate: UICollectionViewDelegate? = nil,
                     dataSource: UICollectionViewDataSource? = nil,
                     registerCells: (AnyClass?, String)...,
                     registerViews: (AnyClass?, String, String)...) {
        
        self.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.delegate = delegate
        self.dataSource = dataSource
        
        registerCells.forEach { self.register($0.0, forCellWithReuseIdentifier: $0.1) }
        registerViews.forEach { self.register($0.0, forSupplementaryViewOfKind: $0.1, withReuseIdentifier: $0.2) }
    }
}

public extension UIStackView {
    
    convenience init(arrangedSubviews views: [UIView] = [],
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     distribution: UIStackView.Distribution = .equalSpacing,
                     alignment: UIStackView.Alignment = .center,
                     spacing: CGFloat = 0) {
        
        self.init(arrangedSubviews: views)
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
