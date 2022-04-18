//
//  FUICollectionViewDelegate.swift
//  fuikit
//
//  Created by Elliot Schrock on 6/18/21.
//

import Foundation
import UIKit

@objc open class FPUICollectionViewDelegate: NSObject, UICollectionViewDelegate {
    public var onDidHighlightItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onDidUnhighlightItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onDidSelectItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onDidDeselectItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onWillDisplayItemAt: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    public var onWillDisplaySupplementaryView: ((UICollectionView, UICollectionReusableView, String, IndexPath) -> Void)?
    public var onDidEndDisplayingCellForItemAt: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    public var onDidEndDisplayingSupplementaryView: ((UICollectionView, UICollectionReusableView, String, IndexPath) -> Void)?
    public var onDidUpdateFocusIn: ((UICollectionView, UICollectionViewFocusUpdateContext, UIFocusAnimationCoordinator) -> Void)?
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
    
    public init(
            onScrollViewDidScroll: @escaping (UIScrollView) -> Void = { _ in },
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
            onScrollViewDidChangeAdjustedContentInset: @escaping (UIScrollView) -> Void = { _ in }
    ){
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
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) { onDidHighlightItemAt?(collectionView, indexPath) }
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) { onDidUnhighlightItemAt?(collectionView, indexPath) }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { onDidSelectItemAt?(collectionView, indexPath) }
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) { onDidDeselectItemAt?(collectionView, indexPath) }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { onWillDisplayItemAt?(collectionView, cell, indexPath) }
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        onWillDisplaySupplementaryView?(collectionView, view, elementKind, indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { onDidEndDisplayingCellForItemAt?(collectionView, cell, indexPath) }
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        onDidEndDisplayingSupplementaryView?(collectionView, view, elementKind, indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) { onDidUpdateFocusIn?(collectionView, context, coordinator) }
    // -MARK: ScrollView Delegate Methods Added
       
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
