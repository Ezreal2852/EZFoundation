//
//  Data.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

/// 图片格式
public enum EZImageFormat {
    case unknown
    case png
    case jpeg
    case gif
    case webp
}

public extension Data {
    
    /// 根据二进制头数据获得图片格式
    var ez_imageFormat: EZImageFormat {
        
        guard count > 8 else { return .unknown }
        
        var buffer = [UInt8](repeating: 0, count: 8)
        copyBytes(to: &buffer, count: 8)
        
        if
            buffer == Header.PNG {
            return .png
        } else if
            buffer[0] == Header.JPEG_SOI[0],
            buffer[1] == Header.JPEG_SOI[1],
            buffer[2] == Header.JPEG_IF[0] {
            return .jpeg
        } else if
            buffer[0] == Header.GIF[0],
            buffer[1] == Header.GIF[1],
            buffer[2] == Header.GIF[2] {
            return .gif
        }
        
        if isWebp { return .webp }
        
        return .unknown
    }
    
    private struct Header {
        static let PNG: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
        static let JPEG_SOI: [UInt8] = [0xFF, 0xD8]
        static let JPEG_IF: [UInt8] = [0xFF]
        static let GIF: [UInt8] = [0x47, 0x49, 0x46]
    }
    
    private var isWebp: Bool {
        
        if count < 12 { return false }

        let endIndex = index(startIndex, offsetBy: 12)
        let testData = subdata(in: startIndex..<endIndex)
        guard let testString = String(data: testData, encoding: .ascii) else {
            return false
        }

        return testString.hasPrefix("RIFF") && testString.hasSuffix("WEBP")
    }
}
