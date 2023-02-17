//
//  Localize.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2023/2/14.
//

//MARK: - 基于[Rswift]+[Localize_Swift]实现的国际化方案，支持自动生成Key和自定义语言
// 如需要应用内切换语言，还需要在一级页面监听语言变化通知，刷新UI

#if canImport(Rswift) && canImport(Localize_Swift)

import Rswift
import Localize_Swift

typealias Strings = R.string.localizable

extension Rswift.StringResource {
    
    /// 国际化
    func localized() -> String {
        key.localized()
    }
    
    /// 国际化带参
    func localizedFormat(_ arguments: CVarArg...) -> String {
        key.localizedFormat(arguments)
    }
}

fileprivate func testLocalize() {
    _ = Strings.xxx.localized()
    _ = Strings.xxx.localizedFormat("xxx")
}

#endif
