//
//  UIViewController+DismissKeyboard.swift
//  LithoUtils
//
//  Created by Calvin Collins on 5/24/21.
//

import UIKit

public extension UIViewController {
    @objc func dismissKeyboard() { view.endEditing(true) }
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
public func addTapToDismissKeyboard(_ vc: UIViewController) {
    vc.addTapToDismissKeyboard()
}

