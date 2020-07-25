//
//  String.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

// MARK: - 字符串处理

public extension String {
    
    /**
     下标
     "stl"[stl: 1] -> "t"
     "stl"[stl: 3] -> nil
     */
    subscript(stl index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return String(self[self.index(startIndex, offsetBy: index)])
    }
    
    /// 截取字符串
    /// - Parameter index: 到这里
    func ez_substring(to index: Int) -> String {
        String(prefix(index))
    }
    
    /// 截取字符串
    /// - Parameter index: 从这里
    func ez_substring(from index: Int) -> String {
        guard index < count else { return "" }
        return String(suffix(count - index))
    }
}

// MARK: - 字符串匹配

public extension String {
    
    /// 正则枚举
    enum EZRegexEnum: String {
        /// QQ号
        case qq = "[1-9][0-9]{4,}"
        /// (国际)电话号码
        case telephone = "^((\\+)|(00)|(\\*)|())[0-9]{3,14}((\\#)|())$"
        /// (国内)手机号
        case phone = "^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$"
        /// 是否为邮箱
        case email = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
        
        // TODO: 把确定的正则都加上
    }
    
    /// 正则匹配
    /// - Parameter regex: 正则表达式
    /// - #"这里的'\'无需转义"#
    func ez_match(regex: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    /// 正则枚举匹配
    func ez_match(_ regex: EZRegexEnum) -> Bool {
        ez_match(regex: regex.rawValue)
    }
}

// MARK: - 字符串计算

public extension String {
    
    /// 计算多行文字的高度
    /// - Parameters:
    ///   - font: 文本字体
    ///   - width: 文本宽度
    func ez_calculateLineHeight(font: UIFont!, width: CGFloat) -> CGFloat {
        self.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                          options: .usesLineFragmentOrigin,
                          attributes: [.font: font!], context: nil).height
    }
}

// MARK: - 编解码

import CommonCrypto

public extension String {
    
    /// MD5 hash 大写值
    var ez_md5: String {
        let str = cString(using: .utf8)
        let strLen = CC_LONG(lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        defer {
            result.deallocate()
        }
        CC_MD5(str!, strLen, result)
        var hash = ""
        for i in 0 ..< digestLen {
            hash = hash.appendingFormat("%02x", result[i])
        }
        return hash.uppercased()
    }
    
    /// base64 编码
    var ez_base64: String? {
        data(using: .utf8)?.base64EncodedString()
    }
    
    /// URL 编码
    var ez_urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    /// URL 解码
    var ez_urlDecoded: String? {
        removingPercentEncoding
    }
}
