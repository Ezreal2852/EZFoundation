//
//  UIButton.swift
//  EZFoundation
//
//  Created by Ezreal on 2020/7/25.
//  Copyright © 2020 EZ. All rights reserved.
//

public extension UIButton {
    
    /// image 相对 label 的位置
    enum EZButtonImagePostion {
        /// image在上，label在下
        case top
        /// image在左，label在右
        case left
        /// image在下，label在上
        case bottom
        /// image在右，label在左
        case right
    }
    
    /// 调整按钮中图片和文字相对位置和间距(基于frame)
    /// - Parameters:
    ///   - position: 图片相对文字的位置
    ///   - space: 间距
    func ez_adjustImageTitlePostionSpace(position: EZButtonImagePostion, space: CGFloat) {
        
        // imageView和titleLabel的宽、高
        let imgW = self.imageView?.frame.size.width ?? 0.0
        let imgH = self.imageView?.frame.size.height ?? 0.0
        let orgLabW = self.titleLabel?.frame.size.width ?? 0.0
        let orgLabH = self.titleLabel?.frame.size.height ?? 0.0
        
        let trueSize = self.titleLabel?.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        let trueLabW = trueSize?.width ?? 0.0
        
        // image中心移动的x距离
        let imageOffsetX = orgLabW / 2.0
        // image中心移动的y距离
        let imageOffsetY = orgLabH / 2.0 + space / 2.0
        // label左边缘移动的x距离
        let labelOffsetX1 = imgW / 2.0 - orgLabW / 2.0 + trueLabW / 2.0
        // label右边缘移动的x距离
        let labelOffsetX2 = imgW / 2.0 + orgLabW / 2.0 - trueLabW / 2.0
        // label中心移动的y距离
        let labelOffsetY = imgH / 2.0 + space / 2.0
        
        // 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = .zero
        var labelEdgeInsets: UIEdgeInsets = .zero
        
        // 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch (position) {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            labelEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX1, bottom: -labelOffsetY, right: labelOffsetX2)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            labelEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX1, bottom: labelOffsetY, right: labelOffsetX2)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -space / 2.0, bottom: 0.0, right: space / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: space / 2.0, bottom: 0.0, right: -space / 2.0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: orgLabW + space / 2.0, bottom: 0.0, right: -(orgLabW + space / 2.0))
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: -(imgW + space / 2.0), bottom: 0.0, right: imgW + space / 2.0)
        }
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = labelEdgeInsets
    }
}
