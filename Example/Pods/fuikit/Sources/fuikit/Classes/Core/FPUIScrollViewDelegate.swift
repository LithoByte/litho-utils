//
//  FPUIScrollViewDelegate.swift
//  fuikit
//
//  Created by Remmington Damper on 11/28/21.
//

import Foundation
import UIKit

@objc open class FPUIScrollViewDelegate: NSObject, UIScrollViewDelegate {
    
    public var onScrollViewDidScroll: (UIScrollView) -> Void = { _ in }
    public var onScrollViewWillBeginDragging: (UIScrollView) -> Void = { _ in }
    public var onScrollViewWillEndDragging: (UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void = { _, _, _ in }
    public var onScrollViewDidEndDragging: (UIScrollView, Bool) -> Void = { _, _ in}
    public var onScrollViewShouldScrollToTop: (UIScrollView) -> Bool = { _ in return true }
    public var onScrollViewDidScrollToTop: (UIScrollView) -> Void = { _ in }
    public var onScrollViewWillBeginDecelerating: (UIScrollView) -> Void = { _ in }
    public var onScrollViewDidEndDecelerating: (UIScrollView) -> Void = { _ in }
    public var onViewForZooming: (UIScrollView) -> UIView? = { _ in return nil}
    public var onScrollViewWillBeginZooming: (UIScrollView, UIView?) -> Void = { _, _ in }
    public var onScrollViewDidEndZooming: (UIScrollView, UIView?, CGFloat) -> Void = { _, _, _ in }
    public var onScrollViewDidZoom: (UIScrollView) -> Void = { _ in }
    public var onScrollViewDidEndScrollingAnimation: (UIScrollView) -> Void = { _ in }
    public var onScrollViewDidChangeAdjustedContentInset: (UIScrollView) -> Void = { _ in }
    
    public init (onScrollViewDidScroll: @escaping (UIScrollView) -> Void = { _ in },
    onScrollViewWillBeginDragging: @escaping (UIScrollView) -> Void = { _ in },
    onScrollViewWillEndDragging: @escaping (UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void = { _, _, _ in },
    onScrollViewDidEndDragging: @escaping (UIScrollView, Bool) -> Void = { _, _ in },
    onScrollViewShouldScrollToTop: @escaping (UIScrollView) -> Bool = {_ in return true },
    onScrollViewDidScrollToTop: @escaping (UIScrollView) -> Void = { _ in },
    onScrollViewWillBeginDecelerating: @escaping (UIScrollView) -> Void = { _ in },
    onScrollViewDidEndDecelerating: @escaping (UIScrollView) -> Void = { _ in },
    onViewForZooming: @escaping (UIScrollView) -> UIView? = {_ in return nil},
    onScrollViewWillBeginZooming: @escaping (UIScrollView, UIView?) -> Void = { _, _ in },
    onScrollViewDidEndZooming: @escaping (UIScrollView, UIView?, CGFloat) -> Void = { _, _, _ in },
    onScrollViewDidZoom: @escaping (UIScrollView) -> Void = { _ in },
    onScrollViewDidEndScrollingAnimation: @escaping (UIScrollView) -> Void = { _ in },
    onScrollViewDidChangeAdjustedContentInset: @escaping (UIScrollView) -> Void = { _ in })
    {
        self.onScrollViewDidScroll = onScrollViewDidScroll
        self.onScrollViewWillBeginDragging = onScrollViewWillBeginDragging
        self.onScrollViewWillEndDragging = onScrollViewWillEndDragging
        self.onScrollViewDidEndDragging = onScrollViewDidEndDragging
        self.onScrollViewShouldScrollToTop = onScrollViewShouldScrollToTop
        self.onScrollViewDidScrollToTop = onScrollViewDidScrollToTop
        self.onScrollViewWillBeginDecelerating = onScrollViewWillBeginDecelerating
        self.onScrollViewDidEndDecelerating = onScrollViewDidEndDecelerating
        self.onViewForZooming = onViewForZooming
        self.onScrollViewWillBeginZooming = onScrollViewWillBeginZooming
        self.onScrollViewDidEndZooming = onScrollViewDidEndZooming
        self.onScrollViewDidZoom = onScrollViewDidZoom
        self.onScrollViewDidEndScrollingAnimation = onScrollViewDidEndScrollingAnimation
        self.onScrollViewDidChangeAdjustedContentInset = onScrollViewDidChangeAdjustedContentInset
    }
    
    @objc open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onScrollViewDidScroll(scrollView)
    }
    @objc open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        onScrollViewWillBeginDragging(scrollView)
    }
    @objc open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        onScrollViewWillEndDragging(scrollView, velocity, targetContentOffset)
    }
    @objc open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        onScrollViewDidEndDragging(scrollView, decelerate)
    }
    @objc open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool
    {
        onScrollViewShouldScrollToTop(scrollView)
    }
    @objc open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        onScrollViewDidScrollToTop(scrollView)
    }
    @objc open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        onScrollViewWillBeginDecelerating(scrollView)
    }
    @objc open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        onScrollViewDidEndDecelerating(scrollView)
    }
    @objc open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        onViewForZooming(scrollView)
    }
    @objc open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        onScrollViewWillBeginZooming(scrollView, view)
    }
    @objc open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        onScrollViewDidEndZooming(scrollView, view, scale)
    }
    @objc open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        onScrollViewDidZoom(scrollView)
    }
    @objc open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        onScrollViewDidEndScrollingAnimation(scrollView)
    }
    @objc open func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        onScrollViewDidChangeAdjustedContentInset(scrollView)
    }
}
