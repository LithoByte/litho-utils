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
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(defaultAlertAction(title: "Okay", handler: ignoreArg(nil *> alert.dismissAnimated)))
    return alert
}

public func alertControllerSafe(title: String?, message: String?, barButton: UIBarButtonItem) -> UIAlertController {
    return alertController(title: title, message: message).configure(barButton -*> popOverCompatibility)
}

public func alertControllerSafe(title: String?, message: String?, sourceView: UIView) -> UIAlertController {
    return alertController(title: title, message: message).configure(sourceView -*> popOverCompatibility)
}

public func alertControllerSafe(title: String?, message: String?, sourceRect: CGRect) -> UIAlertController {
    return alertController(title: title, message: message).configure(sourceRect -*> popOverCompatibility)
}

public func actionSheet(title: String?, message: String?) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    alert.addAction(defaultAlertAction(title: "Okay", handler: ignoreArg(nil *> alert.dismissAnimated)))
    return alert
}

public func actionSheetSafe(title: String?, message: String?, barButton: UIBarButtonItem) -> UIAlertController {
    return actionSheet(title: title, message: message).configure(barButton -*> popOverCompatibility)
}

public func actionSheetSafe(title: String?, message: String?, sourceView: UIView) -> UIAlertController {
    return actionSheet(title: title, message: message).configure(sourceView -*> popOverCompatibility)
}

public func actionSheetSafe(title: String?, message: String?, sourceRect: CGRect) -> UIAlertController {
    return actionSheet(title: title, message: message).configure(sourceRect -*> popOverCompatibility)
}

public func dismissableAlert(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    alert.addAction(defaultAlertAction(title: actionTitle, handler: ignoreArg(onDismiss *> alert.dismissClosure())))
    return alert
}

public func dismissableAlertSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, barButtonItem: UIBarButtonItem) -> UIAlertController {
    return dismissableAlert(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(barButtonItem -*> popOverCompatibility)
}

public func dismissableAlertSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, sourceView: UIView) -> UIAlertController {
    return dismissableAlert(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceView -*> popOverCompatibility)
}

public func dismissableAlertSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, sourceRect: CGRect) -> UIAlertController {
    return dismissableAlert(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceRect -*> popOverCompatibility)
}

public func dismissableActionSheet(title: String?, message: String?, actionTitle: String, onDismiss: @escaping () -> Void = { }) -> UIAlertController {
    let alert = actionSheet(title: title, message: message)
    alert.addAction(defaultAlertAction(title: actionTitle, handler: ignoreArg(onDismiss *> alert.dismissClosure())))
    return alert
}

public func dismissableActionSheetSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, barButtonItem: UIBarButtonItem) -> UIAlertController {
    return dismissableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(barButtonItem -*> popOverCompatibility)
}

public func dismissableActionSheetSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, sourceView: UIView) -> UIAlertController {
    return dismissableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceView -*> popOverCompatibility)
}

public func dismissableActionSheetSafe(title: String?, message: String?, actionTitle: String = "Okay", onDismiss: @escaping () -> Void = { }, sourceRect: CGRect) -> UIAlertController {
    return dismissableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceRect -*> popOverCompatibility)
}

public func cancellableAlert(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    alert.addAction(cancelAlertAction(title: actionTitle, handler: ignoreArg(onDismiss *> alert.dismissClosure())))
    return alert
}

public func cancellableAlertSafe(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }, barButtonItem: UIBarButtonItem) -> UIAlertController {
    return cancellableAlert(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(barButtonItem -*> popOverCompatibility)
}

public func cancellableAlertSafe(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }, sourceView: UIView) -> UIAlertController {
    return cancellableAlert(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceView -*> popOverCompatibility)
}

public func cancellableAlertSafe(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }, sourceRect: CGRect) -> UIAlertController {
    return cancellableAlert(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceRect -*> popOverCompatibility)
}

public func cancellableActionSheet(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }) -> UIAlertController {
    let alert = actionSheet(title: title, message: message)
    alert.addAction(cancelAlertAction(title: actionTitle, handler: ignoreArg(onDismiss *> alert.dismissClosure())))
    return alert
}

public func cancellableActionSheetSafe(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }, barButtonItem: UIBarButtonItem) -> UIAlertController {
    return cancellableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(barButtonItem -*> popOverCompatibility)
}

public func cancellableActionSheetSafe(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }, sourceView: UIView) -> UIAlertController {
    return cancellableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceView -*> popOverCompatibility)
}

public func cancellableActionSheetSafe(title: String?, message: String?, actionTitle: String = "Cancel", onDismiss: @escaping () -> Void = { }, sourceRect: CGRect) -> UIAlertController {
    return cancellableActionSheet(title: title, message: message, actionTitle: actionTitle, onDismiss: onDismiss).configure(sourceRect -*> popOverCompatibility)
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
