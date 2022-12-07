//
//  Operators.swift
//  HeyWorld
//
//  Created by 刘嘉豪 on 2022/12/7.
//

infix operator ?=

func ?=<T> (_ self: inout T, optionl: T?) {
    guard let wrapped = optionl else { return }
    self = wrapped
}

fileprivate func testOptionl() {
    
    var string: String = "string"
    var int: Int = 0
    
    var optionlString: String?
    var optionlInt: Int?
    
    string ?= optionlString
    int ?= optionlInt
    
    print(#function, string, int) // "string", 0
    
    optionlString = "6"
    optionlInt = 6
    
    string ?= optionlString
    int ?= optionlInt
    
    print(#function, string, int) // "6", 6
}
