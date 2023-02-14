//
//  RTL.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/14.
//

import Foundation
import UIKit

//MARK: - is RTL ?

public var isRTL: Bool {
    UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
}

//MARK: - UIEdgeInsets

public func RTLEdgeInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
    isRTL ?
    UIEdgeInsets(top: top, left: right, bottom: bottom, right: left) :
    UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

public func RTLEdgeInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> UIEdgeInsets {
    UIEdgeInsets(top: vertical / 2.0, left: horizontal / 2.0, bottom: vertical / 2.0, right: horizontal / 2.0)
}

public func RTLEdgeInsets(padding: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
}

//MARK: - UICollectionView(Flow)Layout

open class RTLCollectionViewLayout: UICollectionViewLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool { true }
}

open class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool { true }
}

//MARK: - UIScrollView

open class RTLScrollView: UIScrollView {
    
    private let kContentSize = "contentSize"
    
    deinit {
        removeObserver(self, forKeyPath: kContentSize)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        scrollToRightIfNeed()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        scrollToRightIfNeed()
    }
    
    private func scrollToRightIfNeed() { // 监听，当contentSize发生变化时，自动滑到最右边
        guard isRTL else { return }
        
        // 不用RX，可通过KVO实现
//        rx.observe(\.contentSize, options: [.initial, .new]).subscribe(onNext: { [weak self] size in
//            guard let self = self else { return }
//            self.contentOffset = CGPoint(x: max(0, self.contentSize.width - self.bounds.width) + self.contentInset.right, y: self.contentOffset.y)
//        }).disposed(by: rx.disposeBag)
        
        addObserver(self, forKeyPath: kContentSize, options: [.initial, .new], context: nil)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == kContentSize {
            self.contentOffset = CGPoint(x: max(0, self.contentSize.width - self.bounds.width) + self.contentInset.right, y: self.contentOffset.y)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

//MARK: - String(Mixed)

fileprivate let LTRPrefixUnicode = "\u{202A}"
fileprivate let RTLPrefixUnicode = "\u{202B}"

extension String {
    
    public var prefixedRTL: String {
        isRTL ? RTLPrefixUnicode + self : self
    }
}

//MARK: - UIView

extension UIView {
    
    public func flipHorizontallyRTL() {
        guard isRTL else { return }
        transform = CGAffineTransform(scaleX: -1, y: 1)
        subviews.forEach {
            $0.flipHorizontallyRTL()
        }
    }
}

//MARK: - CALayer

extension CALayer {
    
    public func flipHorizontallyRTL() {
        guard isRTL else { return }
        setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
        sublayers?.forEach({
            $0.flipHorizontallyRTL()
        })
    }
}

