//
//  BottomSheet.swift
//  LithoUtils
//
//  Created by Calvin Collins on 10/11/21.
//

import Foundation
import UIKit
import LithoOperators

@available(iOS 15.0, *) public extension UIViewController {
    func presentClosurePageSheet(nav: UINavigationController, detents: [UISheetPresentationController.Detent] = [.medium()]) -> (UIViewController) -> Void {
        return { [weak self] vc in
            nav.setViewControllers([vc], animated: true)
            nav.modalPresentationStyle = .pageSheet
            if let sheet = nav.sheetPresentationController {
                sheet.detents = detents
            }
            self?.presentAnimated(nav)
        }
    }
    
    func presentClosurePageSheet(detents: [UISheetPresentationController.Detent] = [.medium()]) -> (UIViewController) -> Void {
        return { [weak self] vc in
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .pageSheet
            if let sheet = nav.sheetPresentationController {
                sheet.detents = detents
            }
            self?.presentAnimated(nav)
        }
    }
}
