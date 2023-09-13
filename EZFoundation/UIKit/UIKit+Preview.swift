//
//  UIKit+Preview.swift
//  EZ
//
//  Created by 刘嘉豪 on 2023/9/13.
//  Source: https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/
//

#if canImport(SwiftUI) && DEBUG

import SwiftUI
import Foundation
import UIKit

// ViewController Usage:
@available(iOS 13, *)
struct TestViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewController().asPreview()
    }
}

// View Usage:
import SwiftUI
@available(iOS 13, *)
struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        UIView().asPreview()
    }
}

// MARK: - UIViewController extensions
extension UIViewController {
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        var viewController: UIViewController
        func makeUIViewController(context: Context) -> UIViewController { viewController }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(viewController: self)
    }
}

// MARK: - UIView Extensions
extension UIView {
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        var view: UIView
        func makeUIView(context: Context) -> UIView { view }
        func updateUIView(_ view: UIView, context: Context) {}
    }
    
    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(view: self)
    }
}

#endif

