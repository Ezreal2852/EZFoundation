//
//  UIColor.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

public extension UIColor {
    
    /// RGB十进制值颜色
    /// - Parameters:
    ///   - red: 0～255
    ///   - green: 0～255
    ///   - blue: 0～255
    ///   - alpha: 0~1.0
    static func ez_rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// 十六进制数值颜色
    /// - Parameters:
    ///   - num: 十六进制数值 0xffffff
    ///   - alpha: 0~1.0
    static func ez_hex(num: Int, alpha: CGFloat = 1.0) -> UIColor {
        let mask = 0xFF
        let red = (num >> 16) & mask
        let green = (num >> 8) & mask
        let blue = num & mask
        return ez_rgba(red, green, blue, alpha)
    }
    
    /// 十六进制字符串颜色
    /// - Parameters:
    ///   - str: 十六进制字符串 "#ffffff"
    ///   - alpha: 0~1.0
    static func ez_hex(str: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexString = str.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0xFF
        let red = Int(color >> 16) & mask
        let green = Int(color >> 8) & mask
        let blue = Int(color) & mask
        
        return ez_rgba(red, green, blue, alpha)
    }
}
