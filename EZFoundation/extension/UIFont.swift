//
//  UIFont.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

public extension UIFont {
    
    /// 细体
    static func ez_thin(of size: CGFloat, name: String = "PingFangSC-Thin") -> UIFont {
        UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
    }
    
    /// 常规
    static func ez_regular(of size: CGFloat, name: String = "PingFangSC-Regular") -> UIFont {
        UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    /// 中等
    static func ez_medium(of size: CGFloat, name: String = "PingFangSC-Medium") -> UIFont {
        UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    /// 粗体
    static func ez_bold(of size: CGFloat, name: String = "PingFangSC-Semibold") -> UIFont {
        UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
