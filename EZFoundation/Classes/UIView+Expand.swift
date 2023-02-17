//
//  UIView+Expand.swift
//  HeyWorld
//
//  Created by 刘嘉豪 on 2021/1/18.
//

import Foundation

fileprivate let defaultSize = CGSize(width: 44, height: 44)

fileprivate func _point(inside point: CGPoint, with bounds: CGRect) -> Bool? {
    let size = bounds.size
    guard size.width >= defaultSize.width, size.height >= defaultSize.height else {
        let targetBounds = bounds.insetBy(dx: min(0, (size.width - defaultSize.width) / 2.0),
                                          dy: min(0, (size.height - defaultSize.height) / 2.0))
        return targetBounds.contains(point)
    }
    return nil
}

public class ExpandView: UIView {
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        _point(inside: point, with: bounds) ?? super.point(inside: point, with: event)
    }
}

public class ExpandLabel: UILabel {
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        _point(inside: point, with: bounds) ?? super.point(inside: point, with: event)
    }
}

public class ExpandButton: UIButton {
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        _point(inside: point, with: bounds) ?? super.point(inside: point, with: event)
    }
}

public class ExpandImageView: UIImageView {
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        _point(inside: point, with: bounds) ?? super.point(inside: point, with: event)
    }
}
