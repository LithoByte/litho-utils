//
//  FUITableViewDataSource.swift
//  fuikit
//
//  Created by Elliot Schrock on 8/20/20.
//

import UIKit

@objc open class FUITableViewDataSource: NSObject, UITableViewDataSource {
    open var onNumberOfRowsInSection: (UITableView, Int) -> Int = { _, _ in return 0 }
    open var onCellForRowAt: (UITableView, IndexPath) -> UITableViewCell = { _, _ in return UITableViewCell() }
    open var onNumberOfSections: (UITableView) -> Int = { _ in return 0 }
    open var onTitleForHeaderInSection: (UITableView, Int) -> String? = { _, _ in return nil }
    open var onTitleForFooterInSection: (UITableView, Int) -> String? = { _, _ in return nil }
    open var onCanEditRowAt: (UITableView, IndexPath) -> Bool = { _, _ in return false }
    open var onCanMoveRowAt: (UITableView, IndexPath) -> Bool = { _, _ in return false }
    open var onSectionIndexTitles: (UITableView) -> [String]? = { _ in return nil }
    open var onSectionForSectionIndexTitle: (UITableView, String, Int) -> Int = { _, _, _ in return 0 }
    open var onCommitEditingStyleForRowAt: (UITableView, UITableViewCell.EditingStyle, IndexPath) -> Void = { _, _, _ in }
    open var onMoveRowAtTo: (UITableView, IndexPath, IndexPath) -> Void = { _, _, _ in }
    
    public init(onNumberOfRowsInSection: @escaping (UITableView, Int) -> Int = { _, _ in return 0 },
                onCellForRowAt: @escaping (UITableView, IndexPath) -> UITableViewCell = { _, _ in return UITableViewCell() },
                onNumberOfSections: @escaping (UITableView) -> Int = { _ in return 0 },
                onTitleForHeaderInSection: @escaping (UITableView, Int) -> String? = { _, _ in return nil },
                onTitleForFooterInSection: @escaping (UITableView, Int) -> String? = { _, _ in return nil },
                onCanEditRowAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return false },
                onCanMoveRowAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return false },
                onSectionIndexTitles: @escaping (UITableView) -> [String]? = { _ in return nil },
                onSectionForSectionIndexTitle: @escaping (UITableView, String, Int) -> Int = { _, _, _ in return 0 },
                onCommitEditingStyleForRowAt: @escaping (UITableView, UITableViewCell.EditingStyle, IndexPath) -> Void = { _, _, _ in },
                onMoveRowAtTo: @escaping (UITableView, IndexPath, IndexPath) -> Void = { _, _, _ in }) {
        self.onNumberOfRowsInSection = onNumberOfRowsInSection
        self.onCellForRowAt = onCellForRowAt
        self.onNumberOfSections = onNumberOfSections
        self.onTitleForHeaderInSection = onTitleForHeaderInSection
        self.onTitleForFooterInSection = onTitleForFooterInSection
        self.onCanEditRowAt = onCanEditRowAt
        self.onCanMoveRowAt = onCanMoveRowAt
        self.onSectionIndexTitles = onSectionIndexTitles
        self.onSectionForSectionIndexTitle = onSectionForSectionIndexTitle
        self.onCommitEditingStyleForRowAt = onCommitEditingStyleForRowAt
        self.onMoveRowAtTo = onMoveRowAtTo
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onNumberOfRowsInSection(tableView, section)
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return onCellForRowAt(tableView, indexPath)
    }
    open func numberOfSections(in tableView: UITableView) -> Int {
        return onNumberOfSections(tableView)
    }
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return onTitleForFooterInSection(tableView, section)
    }
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return onCanEditRowAt(tableView, indexPath)
    }
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return onCanMoveRowAt(tableView, indexPath)
    }
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return onSectionIndexTitles(tableView)
    }
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return onSectionForSectionIndexTitle(tableView, title, index)
    }
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        onCommitEditingStyleForRowAt(tableView, editingStyle, indexPath)
    }
    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        onMoveRowAtTo(tableView, sourceIndexPath, destinationIndexPath)
    }
}
