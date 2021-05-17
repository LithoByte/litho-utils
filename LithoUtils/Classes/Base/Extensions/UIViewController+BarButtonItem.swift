//
//  UIViewController+PushPop.swift
//  FunNet
//
//  Created by Calvin Collins on 5/17/21.
//

import Foundation

public extension UIViewController {
    func barButtonItem(for imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let barButton = UIBarButtonItem()
        barButton.customView = button
        return barButton
    }
}
