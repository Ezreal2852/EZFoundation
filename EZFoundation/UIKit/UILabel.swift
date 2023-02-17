//
//  UILabel.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/17.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

public extension UILabel {
    
    var requiredHeight: CGFloat {
        requiredSize.height
    }
    
    var requiredWidth: CGFloat {
        requiredSize.width
    }
    
    var requiredSize: CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.size
    }
    
    /// 设置文字渐变色，基于当前frame.size
    func setGgradient(startColor: UIColor, endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {
        textColor = UIColor(patternImage: .gradient(size: requiredSize, startColor: startColor, endColor: endColor, startPoint: startPoint, endPoint: endPoint))
    }
}

#endif
