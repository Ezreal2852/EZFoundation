//
//  UIFont.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

extension UIFont {
    
    /// 苹方
    /// - Parameters:
    ///   - fontSize: 字号
    ///   - weight: 字重
    /// - Returns: 字体
    public static func PingFangSC(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont(name: "PingFangSC-" + weight.suffix, size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}

fileprivate extension UIFont.Weight {
    
    var suffix: String {
        switch self {
        case .ultraLight: return "UltraLight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        default: return "Unknown"
        }
    }
}
