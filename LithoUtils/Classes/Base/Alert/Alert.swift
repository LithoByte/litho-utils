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

public func alertController(title: String?, message: String?) -> UIAlertController {
    let alert = UIAlertController()
    alert.title = title
    alert.message = message
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: ignoreArg({ alert.dismiss(animated: true, completion: nil) })))
    return alert
}

public func dismissableAlert(title: String?, message: String?, actionTitle: String, onDismiss: @escaping () -> Void) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    let action = UIAlertAction(title: actionTitle, style: .default, handler: ignoreArg(onDismiss *> alert.dismissClosure()))
    alert.addAction(action)
    return alert
}

public func dismissableAlert(title: String?, message: String?, actionTitle: String) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    let action = UIAlertAction(title: actionTitle, style: .default, handler: ignoreArg(nil *> alert.dismissClosure()))
    alert.addAction(action)
    return alert
}

public func cancellableAlert(title: String, message: String, actionTitle: String, onDismiss: @escaping (() -> Void)) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    let action = UIAlertAction(title: actionTitle, style: .cancel, handler: ignoreArg(onDismiss *> alert.dismissClosure()))
    alert.addAction(action)
    return alert
}

public func cancellableAlert(title: String, message: String, actionTitle: String) -> UIAlertController {
    let alert = alertController(title: title, message: message)
    let action = UIAlertAction(title: actionTitle, style: .cancel, handler: ignoreArg(nil *> alert.dismissClosure()))
    alert.addAction(action)
    return alert
}

public func popOverCompatibility(for vc: UIViewController, barButtonItem: UIBarButtonItem?) {
    if let popover = vc.popoverPresentationController {
        popover.barButtonItem = barButtonItem
    }
}

public func popOverCompatibility(for vc: UIViewController, from sourceView: UIView) {
    if let popover = vc.popoverPresentationController {
        popover.sourceView = sourceView
    }
}


