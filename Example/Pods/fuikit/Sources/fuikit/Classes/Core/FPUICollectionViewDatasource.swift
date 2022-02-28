//
//  FPUICollectionViewDatasource.swift
//  fuikit
//
//  Created by Remmington Damper on 1/25/22.
//

import Foundation
import UIKit

@objc open class FPUICollectionViewDatasource: NSObject, UICollectionViewDataSource, UIScrollViewDelegate {
    open var onNumberOfItemsInSections: (UICollectionView, Int) -> Int = { _, _ in return 0 }
    open var onNumberOfSections: (UICollectionView) -> Int = { _ in return 0 }
    open var onCellForItemAt: (UICollectionView, IndexPath) -> UICollectionViewCell = { _, _ in return UICollectionViewCell() }
    open var onViewForSupplementaryElementOfKind: (UICollectionView, String, IndexPath) -> UICollectionReusableView = {_, _, _ in return UICollectionReusableView()}
    open var onCanMoveItemAt: (UICollectionView, IndexPath) -> Bool = { _, _ in return false }
    open var onMoveItemAtToDestination: (UICollectionView, IndexPath, IndexPath) -> Void = {_, _, _ in }
    open var onIndexTitlesFor: ((UICollectionView) -> [String]?)? = {_ in return [String]() }
    open var onIndexPathForIndexTitle: (UICollectionView, String, Int) -> IndexPath = {_, _, _ in return IndexPath()}

    
    public init(
        onNumberOfItemsInSections: @escaping (UICollectionView, Int) -> Int = { _, _ in return 0},
        onNumberOfSections: @escaping (UICollectionView) -> Int = { _ in return 0},
        onCellForItemAt: @escaping (UICollectionView, IndexPath) -> UICollectionViewCell = { _, _ in return UICollectionViewCell()},
        onViewForSupplementaryElementOfKind: @escaping (UICollectionView, String, IndexPath) -> UICollectionReusableView = {_, _, _ in return UICollectionReusableView()},
        onCanMoveItemAt: @escaping (UICollectionView, IndexPath) -> Bool = {_, _ in return false },
        onMoveItemAtToDestination: @escaping (UICollectionView, IndexPath, IndexPath) -> Void = { _, _, _ in},
        onIndexTitlesFor: ((UICollectionView) -> [String]?)? = { _ in [String]() },
        onIndexPathForIndexTitle: @escaping (UICollectionView, String, Int) -> IndexPath = {_, _, _ in return IndexPath() }
    ){
        self.onNumberOfItemsInSections = onNumberOfItemsInSections
        self.onNumberOfSections = onNumberOfSections
        self.onCellForItemAt = onCellForItemAt
        self.onViewForSupplementaryElementOfKind = onViewForSupplementaryElementOfKind
        self.onCanMoveItemAt = onCanMoveItemAt
        self.onMoveItemAtToDestination = onMoveItemAtToDestination
        self.onIndexTitlesFor = onIndexTitlesFor
        self.onIndexPathForIndexTitle = onIndexPathForIndexTitle
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onNumberOfItemsInSections(collectionView, section)
    }
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        onNumberOfSections(collectionView)
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        onCellForItemAt(collectionView, indexPath)
    }
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        onViewForSupplementaryElementOfKind(collectionView, kind, indexPath)
    }
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        onCanMoveItemAt(collectionView, indexPath)
    }
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        onMoveItemAtToDestination(collectionView, sourceIndexPath, destinationIndexPath)
    }
    open func indexTitles(for collectionView: UICollectionView) -> [String]? {
        onIndexTitlesFor?(collectionView)
    }
    open func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        onIndexPathForIndexTitle(collectionView, title, index)
    }
    
}
