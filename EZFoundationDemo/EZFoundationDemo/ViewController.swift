//
//  ViewController.swift
//  EZFoundationDemo
//
//  Created by 刘嘉豪 on 2022/6/1.
//

import UIKit
import EZFoundation

class ViewController: UIViewController {
    
    @UserDefault("kMyInt") var myInt: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

