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
    
    /// 高斯模糊
    /// - Parameter radius: 模糊半径
    func gaussianBlur(radius: CGFloat = 20) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(floatLiteral: radius), forKey: kCIInputRadiusKey)
        
        guard let resultCiImage = filter.value(forKey: kCIOutputImageKey) as? CIImage,
              let resultCgImage = CIContext().createCGImage(resultCiImage, from: ciImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: resultCgImage)
    }
    
    /// 高斯模糊，但是异步
    /// - Parameters:
    ///   - radius: 模糊半径
    ///   - compeltion: 回调
    func gaussianBlur(radius: CGFloat = 20, compeltion: ((UIImage?) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            let result = self?.gaussianBlur(radius: radius)
            DispatchQueue.main.async {
                compeltion?(result)
            }
        }
    }
}
