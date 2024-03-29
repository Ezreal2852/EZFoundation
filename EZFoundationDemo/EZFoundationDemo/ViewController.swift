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
    
    fileprivate lazy var leakView = TestLeakView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leakView.tap = handleLeak // ❌
        
        leakView.tap = { [weak self] in // ✅
            self?.handleLeak()
        }
    }
    
    fileprivate func handleLeak() { // [weak self] in 这样写也会报错：Cannot find 'weak' in scope
        weak var `self` = self // 哪怕这样写，在{}作用域内，等号右边的self仍会被强引用
        guard let self = self else { return }
        print(self, "此时，这里的self都会被leakView.tap强引用，从而产生循环引用！")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            if touch.view == view {
                present(WeakViewController(), animated: true)
                break
            }
        }
    }
}

fileprivate class TestLeakView: UIView {
    // ⚠️需要谨慎把func当closure来使用！
    var tap: (() -> Void)?
}


class WeakViewController: UIViewController {
    
    deinit {
        print(#function, self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWeakObject(self)
        
        if let weakSelf: WeakViewController = getWeakObject() {
            print(#function, weakSelf)
        }
    }
}

