//
//  FPUITabBarControllerDelegate.swift
//  fuikit
//
//  Created by Remmington Damper on 12/8/21.
//

import Foundation
import UIKit

open class FPUITabBarControllerDelegate: NSObject, UITabBarControllerDelegate {
    
    public var onTabBarControllerShouldSelect : (UITabBarController, UIViewController) -> Bool = { _, _ in return true}
    public var onTabBarControllerDidSelect : (UITabBarController, UIViewController) -> Void = { _, _ in }
    public var onTabBarControllerWillBeginCustomizing : (UITabBarController, [UIViewController]) -> Void = { _, _ in }
    public var onTabBarControllerWillEndCustomizing : (UITabBarController, [UIViewController], Bool) -> Void = {
        _, _, _ in
    }
    public var onTabBarControllerDidEndCustomizing : (UITabBarController, [UIViewController], Bool) -> Void = {
        _, _, _ in
    }
    public var onTabBarControllerSupportedInterfaceOrientations : (UITabBarController) -> UIInterfaceOrientationMask = { _ in return .portrait}
    public var onTabBarControllerPreferredInterfaceOrientationForPresentation : (UITabBarController) -> UIInterfaceOrientation = { _ in return .portrait}
    public var onTabBarControllerAnimationControllerTransitionFrom : (UITabBarController, UIViewController, UIViewController) ->  UIViewControllerAnimatedTransitioning? = { _, _, _ in return nil}
    public var onTabBarControllerInteractionControllerFor : (UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? = { _, _ in return nil}
    
    public init
    (onTabBarControllerShouldSelect: @escaping (UITabBarController, UIViewController) -> Bool = { _, _ in return true},
        onTabBarControllerDidSelect: @escaping (UITabBarController, UIViewController) -> Void = { _, _ in },
     onTabBarControllerWillBeginCustomizing: @escaping (UITabBarController, [UIViewController]) -> Void = {_, _ in },
     onTabBarControllerWillEndCustomizing: @escaping (UITabBarController, [UIViewController], Bool) -> Void = { _, _, _ in },
     onTabBarControllerDidEndCustomizing: @escaping (UITabBarController, [UIViewController], Bool) -> Void = {_, _, _ in },
     onTabBarControllerSupportedInterfaceOrientations: @escaping (UITabBarController) -> UIInterfaceOrientationMask = { _ in return .portrait},
     onTabBarControllerPreferredInterfaceOrientationForPresentation: @escaping (UITabBarController) -> UIInterfaceOrientation = { _ in return .portrait},
     onTabBarControllerAnimationControllerTransitionFrom: @escaping (UITabBarController, UIViewController, UIViewController) -> UIViewControllerAnimatedTransitioning? = { _, _, _ in return nil},
     onTabBarControllerInteractionControllerFor: @escaping (UITabBarController, UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? = { _, _ in return nil}
    )
    {
        self.onTabBarControllerShouldSelect = onTabBarControllerShouldSelect
        self.onTabBarControllerDidSelect = onTabBarControllerDidSelect
        self.onTabBarControllerWillBeginCustomizing = onTabBarControllerWillBeginCustomizing
        self.onTabBarControllerWillEndCustomizing = onTabBarControllerWillEndCustomizing
        self.onTabBarControllerDidEndCustomizing = onTabBarControllerDidEndCustomizing
        self.onTabBarControllerSupportedInterfaceOrientations = onTabBarControllerSupportedInterfaceOrientations
        self.onTabBarControllerPreferredInterfaceOrientationForPresentation = onTabBarControllerPreferredInterfaceOrientationForPresentation
        self.onTabBarControllerAnimationControllerTransitionFrom = onTabBarControllerAnimationControllerTransitionFrom
        self.onTabBarControllerInteractionControllerFor = onTabBarControllerInteractionControllerFor
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        onTabBarControllerShouldSelect(tabBarController, viewController)
    }
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        onTabBarControllerDidSelect(tabBarController, viewController)
    }
    public func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
        onTabBarControllerWillBeginCustomizing(tabBarController, viewControllers)
    }
    public func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        onTabBarControllerWillEndCustomizing(tabBarController, viewControllers, changed)
    }
    public func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        onTabBarControllerDidEndCustomizing(tabBarController, viewControllers, changed)
    }
    
    public func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController) -> UIInterfaceOrientationMask {
        onTabBarControllerSupportedInterfaceOrientations(tabBarController)
    }
    public func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController) -> UIInterfaceOrientation {
        onTabBarControllerPreferredInterfaceOrientationForPresentation(tabBarController)
    }
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        onTabBarControllerAnimationControllerTransitionFrom(tabBarController, fromVC, toVC)
    }
    public func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        onTabBarControllerInteractionControllerFor(tabBarController, animationController)
    }
    
}
