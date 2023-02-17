//
//  UIScrollView.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/17.
//

#if canImport(RxCocoa) && canImport(SnapKit)

import RxCocoa
import SnapKit

public extension UIScrollView {
    
    /// 基于自动布局，通过KVO实现frame.height和content.height同步；前提：需设置过高度的约束，否则无法更新
    func autoLayoutFrameHeightToContentHeight() {
        rx.observe(\.contentSize).subscribe(with: self, onNext: { (self, contentSize) in
            if bounds.height == contentSize.height { return }
            self.snp.updateConstraints { make in
                make.height.equalTo(contentSize.height)
            }
        }).disposed(by: rx.disposeBag)
    }
}

#endif
