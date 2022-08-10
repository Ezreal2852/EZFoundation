//
//  Operator.swift
//  EZFoundation
//
//  Created by 刘嘉豪 on 2022/8/10.
//

infix operator ?=

/// 可选赋值运算符，同OC中的'?='，仅右边值不为空时，向左边赋值
/// - Parameters:
///   - self: 被赋值的对象，可变但不为空
///   - optional: 被赋值的值，可为空
public func ?= <T> (self: inout T, optional: T?) {
    guard let optional = optional else { return }
    self = optional
}
