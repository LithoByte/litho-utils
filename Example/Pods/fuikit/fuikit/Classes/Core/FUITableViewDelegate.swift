//
//  FUITableViewDelegate.swift
//  fuikit
//
//  Created by Elliot Schrock on 6/9/18.
//

import UIKit

/**
 This class implements UITableViewDelegate, with some important exceptions. There are several functions in UITableViewDelegate that
 merely implementing will change the behavior of the UITableView. These functions include the height or estimated height of a row, header, or footer
 since these functions take precedence over static values you can provide the table view and there's no way to provide an ignored value if you
 implement them, as well as the functions for providing a header or footer view, for the same reasons.
 */
@objc open class FUITableViewDelegate: NSObject, UITableViewDelegate {
    public var onSelect: (UITableView, IndexPath) -> Void = { _,_ in }
    public var onWillDisplay: (UITableViewCell, UITableView, IndexPath) -> Void = { _,_,_ in }
    
    public var onWillDisplayHeaderView: (UITableView, UIView, Int) -> Void = { _, _, _ in }
    public var onWillDisplayFooterView: (UITableView, UIView, Int) -> Void = { _, _, _ in }
    public var onDidEndDisplaying: (UITableView, UITableViewCell, IndexPath) -> Void = { _, _, _ in }
    public var onDidEndDisplayingHeaderView: (UITableView, UIView, Int) -> Void = { _, _, _ in }
    public var onDidEndDisplayingFooterView: (UITableView, UIView, Int) -> Void = { _, _, _ in }
    
    public var onAccessoryButtonTappedForRowWith: (UITableView, IndexPath) -> Void = { _, _ in }
    
    public var onShouldHighlightRowAt: (UITableView, IndexPath) -> Bool = { _, _ in return true }
    public var onDidHighlightRowAt: (UITableView, IndexPath) -> Void = { _, _ in }
    public var onDidUnhighlightRowAt: (UITableView, IndexPath) -> Void = { _, _ in }
    
    public var onWillSelectRowAt: (UITableView, IndexPath) -> IndexPath? = { $1 }
    public var onWillDeselectRowAt: (UITableView, IndexPath) -> IndexPath? = { $1 }
    
    public var onDidSelectRowAt: (UITableView, IndexPath) -> Void = { _, _ in }
    public var onDidDeselectRowAt: (UITableView, IndexPath) -> Void = { _, _ in }
    
    public var onEditingStyleForRowAt: (UITableView, IndexPath) -> UITableViewCell.EditingStyle = { _, _ in return .none }
    
    public var onTitleForDeleteConfirmationButtonForRowAt: (UITableView, IndexPath) -> String? = { _, _ in return nil }
    
    public var onEditActionsForRowAt: (UITableView, IndexPath) -> [UITableViewRowAction]? = { _, _ in return nil }
    
    public var onLeadingSwipeActionsConfigurationForRowAt: (UITableView, IndexPath) -> UISwipeActionsConfiguration? = { _, _ in return nil }
    public var onTrailingSwipeActionsConfigurationForRowAt: (UITableView, IndexPath) -> UISwipeActionsConfiguration? = { _, _ in return nil }
    
    public var onShouldIndentWhileEditingRowAt: (UITableView, IndexPath) -> Bool = { _, _ in return true }
    
    public var onWillBeginEditingRowAt: (UITableView, IndexPath) -> Void = { _, _ in }
    public var onDidEndEditingRowAt: (UITableView, IndexPath?) -> Void = { _, _ in }
    
    public var onShouldShowMenuForRowAt: (UITableView, IndexPath) -> Bool = { _, _ in return true }
    
    public var onCanPerformAction: (UITableView, Selector, IndexPath, Any?) -> Bool = { _, _, _, _ in return true }
    public var onPerformAction: (UITableView, Selector, IndexPath, Any?) -> Void = { _, _, _, _ in }
    
    public var onCanFocusRowAt: (UITableView, IndexPath) -> Bool = { _, _ in return true }
    public var onShouldUpdateFocusIn: (UITableView, UITableViewFocusUpdateContext) -> Bool = { _, _ in return true }
    
    public var onDidUpdateFocusIn: (UITableView, UITableViewFocusUpdateContext, UIFocusAnimationCoordinator) -> Void = { _, _, _ in }
    public var onIndexPathForPreferredFocusedView: (UITableView) -> IndexPath? = { _ in return nil }
    
    public var onShouldSpringLoadRowAt: (UITableView, IndexPath, UISpringLoadedInteractionContext) -> Bool = { _, _, _ in return true }
    
    public var onShouldBeginMultipleSelectionInteractionAt: (UITableView, IndexPath) -> Bool = { _, _ in return true }
    
    public var onDidBeginMultipleSelectionInteractionAt: (UITableView, IndexPath) -> Void = { _, _ in }
    public var onTableViewDidEndMultipleSelectionInteraction: (UITableView) -> Void = { _ in }
    
    public init(onSelect: @escaping (UITableView, IndexPath) -> Void = { _,_ in },
                onWillDisplay: @escaping (UITableViewCell, UITableView, IndexPath) -> Void = { _,_,_ in },
                onWillDisplayHeaderView: @escaping (UITableView, UIView, Int) -> Void = { _, _, _ in },
                onWillDisplayFooterView: @escaping (UITableView, UIView, Int) -> Void = { _, _, _ in },
                onDidEndDisplaying: @escaping (UITableView, UITableViewCell, IndexPath) -> Void = { _, _, _ in },
                onDidEndDisplayingHeaderView: @escaping (UITableView, UIView, Int) -> Void = { _, _, _ in },
                onDidEndDisplayingFooterView: @escaping (UITableView, UIView, Int) -> Void = { _, _, _ in },
                onAccessoryButtonTappedForRowWith: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onShouldHighlightRowAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return true },
                onDidHighlightRowAt: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onDidUnhighlightRowAt: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onWillSelectRowAt: @escaping (UITableView, IndexPath) -> IndexPath? = { $1 },
                onWillDeselectRowAt: @escaping (UITableView, IndexPath) -> IndexPath? = { $1 },
                onDidSelectRowAt: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onDidDeselectRowAt: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onEditingStyleForRowAt: @escaping (UITableView, IndexPath) -> UITableViewCell.EditingStyle = { _, _ in return .none },
                onTitleForDeleteConfirmationButtonForRowAt: @escaping (UITableView, IndexPath) -> String? = { _, _ in return nil },
                onEditActionsForRowAt: @escaping (UITableView, IndexPath) -> [UITableViewRowAction]? = { _, _ in return nil },
                onLeadingSwipeActionsConfigurationForRowAt: @escaping (UITableView, IndexPath) -> UISwipeActionsConfiguration? = { _, _ in return nil },
                onTrailingSwipeActionsConfigurationForRowAt: @escaping (UITableView, IndexPath) -> UISwipeActionsConfiguration? = { _, _ in return nil },
                onShouldIndentWhileEditingRowAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return true },
                onWillBeginEditingRowAt: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onDidEndEditingRowAt: @escaping (UITableView, IndexPath?) -> Void = { _, _ in },
                onShouldShowMenuForRowAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return true },
                onCanPerformAction: @escaping (UITableView, Selector, IndexPath, Any?) -> Bool = { _, _, _, _ in return true },
                onPerformAction: @escaping (UITableView, Selector, IndexPath, Any?) -> Void = { _, _, _, _ in },
                onCanFocusRowAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return true },
                onShouldUpdateFocusIn: @escaping (UITableView, UITableViewFocusUpdateContext) -> Bool = { _, _ in return true },
                onDidUpdateFocusIn: @escaping (UITableView, UITableViewFocusUpdateContext, UIFocusAnimationCoordinator) -> Void = { _, _, _ in },
                onIndexPathForPreferredFocusedView: @escaping (UITableView) -> IndexPath? = { _ in return nil },
                onShouldSpringLoadRowAt: @escaping (UITableView, IndexPath, UISpringLoadedInteractionContext) -> Bool = { _, _, _ in return true },
                onShouldBeginMultipleSelectionInteractionAt: @escaping (UITableView, IndexPath) -> Bool = { _, _ in return true },
                onDidBeginMultipleSelectionInteractionAt: @escaping (UITableView, IndexPath) -> Void = { _, _ in },
                onTableViewDidEndMultipleSelectionInteraction: @escaping (UITableView) -> Void = { _ in }) {
        self.onSelect = onSelect
        self.onWillDisplay = onWillDisplay
        self.onWillDisplayHeaderView = onWillDisplayHeaderView
        self.onWillDisplayFooterView = onWillDisplayFooterView
        self.onDidEndDisplaying = onDidEndDisplaying
        self.onDidEndDisplayingHeaderView = onDidEndDisplayingHeaderView
        self.onDidEndDisplayingFooterView = onDidEndDisplayingFooterView
        self.onAccessoryButtonTappedForRowWith = onAccessoryButtonTappedForRowWith
        self.onShouldHighlightRowAt = onShouldHighlightRowAt
        self.onDidHighlightRowAt = onDidHighlightRowAt
        self.onDidUnhighlightRowAt = onDidUnhighlightRowAt
        self.onWillSelectRowAt = onWillSelectRowAt
        self.onWillDeselectRowAt = onWillDeselectRowAt
        self.onDidSelectRowAt = onDidSelectRowAt
        self.onDidDeselectRowAt = onDidDeselectRowAt
        self.onEditingStyleForRowAt = onEditingStyleForRowAt
        self.onTitleForDeleteConfirmationButtonForRowAt = onTitleForDeleteConfirmationButtonForRowAt
        self.onEditActionsForRowAt = onEditActionsForRowAt
        self.onLeadingSwipeActionsConfigurationForRowAt = onLeadingSwipeActionsConfigurationForRowAt
        self.onTrailingSwipeActionsConfigurationForRowAt = onTrailingSwipeActionsConfigurationForRowAt
        self.onShouldIndentWhileEditingRowAt = onShouldIndentWhileEditingRowAt
        self.onWillBeginEditingRowAt = onWillBeginEditingRowAt
        self.onDidEndEditingRowAt = onDidEndEditingRowAt
        self.onShouldShowMenuForRowAt = onShouldShowMenuForRowAt
        self.onCanPerformAction = onCanPerformAction
        self.onPerformAction = onPerformAction
        self.onCanFocusRowAt = onCanFocusRowAt
        self.onShouldUpdateFocusIn = onShouldUpdateFocusIn
        self.onDidUpdateFocusIn = onDidUpdateFocusIn
        self.onIndexPathForPreferredFocusedView = onIndexPathForPreferredFocusedView
        self.onShouldSpringLoadRowAt = onShouldSpringLoadRowAt
        self.onShouldBeginMultipleSelectionInteractionAt = onShouldBeginMultipleSelectionInteractionAt
        self.onDidBeginMultipleSelectionInteractionAt = onDidBeginMultipleSelectionInteractionAt
        self.onTableViewDidEndMultipleSelectionInteraction = onTableViewDidEndMultipleSelectionInteraction
    }
    
    @objc open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onWillDisplay(cell, tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        onWillDisplayHeaderView(tableView, view, section)
    }
    @objc open func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        onWillDisplayFooterView(tableView, view, section)
    }
    @objc open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onDidEndDisplaying(tableView, cell, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        onDidEndDisplayingHeaderView(tableView, view, section)
    }
    @objc open func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        onDidEndDisplayingFooterView(tableView, view, section)
    }
    @objc open func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        onAccessoryButtonTappedForRowWith(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return onShouldHighlightRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        onDidHighlightRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        onDidUnhighlightRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return onWillSelectRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return onWillDeselectRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        onDidDeselectRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return onEditingStyleForRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return onTitleForDeleteConfirmationButtonForRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return onEditActionsForRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return onLeadingSwipeActionsConfigurationForRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return onTrailingSwipeActionsConfigurationForRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return onShouldIndentWhileEditingRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        onWillBeginEditingRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        onDidEndEditingRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return onShouldShowMenuForRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return onCanPerformAction(tableView, action, indexPath, sender)
    }
    @objc open func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        onPerformAction(tableView, action, indexPath, sender)
    }
    @objc open func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return onCanFocusRowAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return onShouldUpdateFocusIn(tableView, context)
    }
    @objc open func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        onDidUpdateFocusIn(tableView, context, coordinator)
    }
    @objc open func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return onIndexPathForPreferredFocusedView(tableView)
    }
    @objc open func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return onShouldSpringLoadRowAt(tableView, indexPath, context)
    }
    @objc open func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return onShouldBeginMultipleSelectionInteractionAt(tableView, indexPath)
    }
    @objc open func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        onDidBeginMultipleSelectionInteractionAt(tableView, indexPath)
    }
    @objc open func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        onTableViewDidEndMultipleSelectionInteraction(tableView)
    }
}
