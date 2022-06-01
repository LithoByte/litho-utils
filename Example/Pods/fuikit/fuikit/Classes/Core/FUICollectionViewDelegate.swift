//
//  FUICollectionViewDelegate.swift
//  fuikit
//
//  Created by Elliot Schrock on 6/18/21.
//

import Foundation

open class FUICollectionViewDelegate: NSObject, UICollectionViewDelegate {
    public var onDidHighlightItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onDidUnhighlightItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onDidSelectItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onDidDeselectItemAt: ((UICollectionView, IndexPath) -> Void)?
    public var onWillDisplayItemAt: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    public var onWillDisplaySupplementaryView: ((UICollectionView, UICollectionReusableView, String, IndexPath) -> Void)?
    public var onDidEndDisplayingCellForItemAt: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    public var onDidEndDisplayingSupplementaryView: ((UICollectionView, UICollectionReusableView, String, IndexPath) -> Void)?
    public var onDidUpdateFocusIn: ((UICollectionView, UICollectionViewFocusUpdateContext, UIFocusAnimationCoordinator) -> Void)?
    
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
}
