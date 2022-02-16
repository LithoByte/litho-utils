//
//  KeyboardDismissable.swift
//  LithoUtils
//
//  Created by Calvin Collins on 1/27/22.
//

import Foundation
import LithoOperators
import UIKit

@objc public protocol AccessoryViewConfigurable {
    var responder: UIResponder? { get set }
    
    @objc func barButtonPressed()
}

public func alignRightConfigurer(toolbar: UIToolbar = UIToolbar(), barButton: UIBarButtonItem) -> (AccessoryViewConfigurable) -> Void {
    return { dismissable in
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        barButton.target = dismissable
        barButton.action = #selector(dismissable.barButtonPressed)
        toolbar.items = [flexSpace, barButton]
        toolbar.sizeToFit()
        dismissable.responder ?> (~>set(\UITextField.inputAccessoryView, toolbar))
        dismissable.responder ?> (~>set(\UITextView.inputAccessoryView, toolbar))
    }
}

public func alignLeftConfigurer(toolbar: UIToolbar = UIToolbar(), barButton: UIBarButtonItem) -> (AccessoryViewConfigurable) -> Void {
    return { dismissable in
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        barButton.target = dismissable
        barButton.action = #selector(dismissable.barButtonPressed)
        toolbar.items = [barButton, flexSpace]
        toolbar.sizeToFit()
        dismissable.responder ?> (~>set(\UITextField.inputAccessoryView, toolbar))
        dismissable.responder ?> (~>set(\UITextView.inputAccessoryView, toolbar))
    }
}

