//
//  UIImage.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/17.
//

import Foundation

public extension UIImage {
    
    /// 生成渐变色图片
    static func gradient(size: CGSize,
                         startColor: UIColor, endColor: UIColor,
                         startPoint: CGPoint, endPoint: CGPoint) -> UIImage {
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let gradientLocations: [CGFloat] = [0.0, 1.0]
        let colors: CFArray = [startColor.cgColor, endColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: colorspace, colors: colors, locations: gradientLocations)
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        
        let render = UIGraphicsImageRenderer(bounds: .init(origin: .zero, size: size), format: format)
        
        let image = render.image { context in
            context.cgContext.drawLinearGradient(gradient!,
                                                 start: CGPoint(x: size.width * startPoint.x, y: size.height * startPoint.y),
                                                 end: CGPoint(x: size.width * endPoint.x, y: size.height * endPoint.y),
                                                 options: .drawsAfterEndLocation)
        }
        
        return image
    }
}
