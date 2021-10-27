//
//  Alerts.swift
//  LUX
//
//  Created by Calvin Collins on 5/4/21.
//

import Foundation
import LithoOperators
import Prelude
import fuikit

public func defaultAlertAction(title: String, handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
    return UIAlertAction(title: title, style: .default, handler: handler)
}

public func cancelAlertAction(title: String, handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
    return UIAlertAction(title: title, style: .cancel, handler: handler)
}

public func alertController(title: String?, message: String?) -> UIAlertController {
    return UIAlertController(title: title, message: message, preferredStyle: .alert)
}

public func configureForDismiss(alert: UIAlertController, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }) {
    alert.addAction(defaultAlertAction(title: actionTitle, handler: ignoreArg(union(nil *> alert.dismissClosure(), onDismiss))))
}

public func configureForCancel(alert: UIAlertController, actionTitle: String = "Cancel", onCancel: @escaping () -> Void = { }) {
    alert.addAction(cancelAlertAction(title: actionTitle, handler: ignoreArg(union(nil *> alert.dismissClosure(), onCancel))))
}

// Private because it's a helper method
private func actionSheet(title: String?, message: String?) -> UIAlertController {
    return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
}

public func actionSheetPopoverSafe(title: String?, message: String?, barButton: UIBarButtonItem) -> UIAlertController {
    return actionSheet(title: title, message: message).configure(barButton -*> popOverCompatibility)
}

public func actionSheetPopoverSafe(title: String?, message: String?, sourceView: UIView) -> UIAlertController {
    return actionSheet(title: title, message: message).configure(sourceView -*> popOverCompatibility)
}

public func actionSheetPopoverSafe(title: String?, message: String?, sourceRect: CGRect) -> UIAlertController {
    return actionSheet(title: title, message: message).configure(sourceRect -*> popOverCompatibility)
}

public func dismissableAlert(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    configureForDismiss(alert: alert, actionTitle: actionTitle, onDismiss: onDismiss)
    return alert
}

private func dismissableActionSheet(title: String?, message: String?, actionTitle: String, onDismiss: @escaping () -> Void = { }) -> UIAlertController {
    let alert = actionSheet(title: title, message: message)
    configureForDismiss(alert: alert, actionTitle: actionTitle, onDismiss: onDismiss)
    return alert
}

public func dismissableActionSheetPopoverSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, barButtonItem: UIBarButtonItem) -> UIAlertController {
    return dismissableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(barButtonItem -*> popOverCompatibility)
}

public func dismissableActionSheetPopoverSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, sourceView: UIView) -> UIAlertController {
    return dismissableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceView -*> popOverCompatibility)
}

public func dismissableActionSheetPopoverSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, sourceRect: CGRect) -> UIAlertController {
    return dismissableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceRect -*> popOverCompatibility)
}

public func cancellableAlert(title: String?, message: String?, actionTitle: String = "Cancel", onCancel: @escaping () -> Void = { }) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    configureForCancel(alert: alert, actionTitle: actionTitle, onCancel: onCancel)
    return alert
}

private func cancellableActionSheet(title: String?, message: String?, actionTitle: String = "Cancel", onCancel: @escaping () -> Void = { }) -> UIAlertController {
    let alert = actionSheet(title: title, message: message)
    configureForCancel(alert: alert, actionTitle: actionTitle, onCancel: onCancel)
    return alert
}

public func cancellableActionSheetPopoverSafe(title: String?, message: String?, actionTitle: String = "Cancel", onCancel: @escaping () -> Void = { }, barButtonItem: UIBarButtonItem) -> UIAlertController {
    return cancellableActionSheet(title: title, message: message, actionTitle: actionTitle, onCancel: onCancel).configure(barButtonItem -*> popOverCompatibility)
}

public func cancellableActionSheetPopoverSafe(title: String?, message: String?, actionTitle: String = "Cancel", onCancel: @escaping () -> Void = { }, sourceView: UIView) -> UIAlertController {
    return cancellableActionSheet(title: title, message: message, actionTitle: actionTitle, onCancel: onCancel).configure(sourceView -*> popOverCompatibility)
}

public func cancellableActionSheetPopoverSafe(title: String?, message: String?, actionTitle: String = "Cancel", onCancel: @escaping () -> Void = { }, sourceRect: CGRect) -> UIAlertController {
    return cancellableActionSheet(title: title, message: message, actionTitle: actionTitle, onCancel: onCancel).configure(sourceRect -*> popOverCompatibility)
}

public func popOverCompatibility(for vc: UIViewController, barButtonItem: UIBarButtonItem) {
    if let popover = vc.popoverPresentationController {
        popover.barButtonItem = barButtonItem
    }
}

public func popOverCompatibility(for vc: UIViewController, from sourceView: UIView) {
    if let popover = vc.popoverPresentationController {
        popover.sourceView = sourceView
        popover.sourceRect = CGRect(x: sourceView.frame.midX, y: sourceView.frame.midY, width: 0, height: 0)
    }
}

public func popOverCompatibility(for vc: UIViewController, from sourceRect: CGRect) {
    if let popover = vc.popoverPresentationController {
        popover.sourceRect = sourceRect
    }
}
