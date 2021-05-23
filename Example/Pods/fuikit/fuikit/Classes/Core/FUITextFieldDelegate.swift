//
//  FUITextFieldDelegate.swift
//  fuikit
//
//  Created by Elliot Schrock on 6/19/20.
//

import UIKit

@available(iOS 10.0, *)
public class FUITextFieldDelegate: NSObject, UITextFieldDelegate {
    public var onTextFieldShouldBeginEditing: ((UITextField) -> Bool)?
    public var onTextFieldDidBeginEditing: ((UITextField) -> Void)?
    public var onTextFieldShouldEndEditing: ((UITextField) -> Bool)?
    public var onTextFieldDidEndEditing: ((UITextField) -> Void)?
    public var onTextFieldDidEndEditingWithReason: ((UITextField, UITextField.DidEndEditingReason) -> Void)?
    public var onTextFieldShouldChange: ((UITextField, NSRange, String) -> Bool)?
    public var onTextFieldDidChangeSelection: ((UITextField) -> Void)?
    public var onTextFieldShouldClear: ((UITextField) -> Bool)?
    public var onTextFieldShouldReturn: ((UITextField) -> Bool)?
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool { return onTextFieldShouldBeginEditing?(textField) ?? true }
    public func textFieldDidBeginEditing(_ textField: UITextField) { onTextFieldDidBeginEditing?(textField) }
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { return onTextFieldShouldEndEditing?(textField) ?? true }
    public func textFieldDidEndEditing(_ textField: UITextField) { onTextFieldDidEndEditing?(textField) }
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) { onTextFieldDidEndEditingWithReason?(textField, reason) }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return onTextFieldShouldChange?(textField, range, string) ?? true }
    public func textFieldDidChangeSelection(_ textField: UITextField) { onTextFieldDidChangeSelection?(textField) }
    public func textFieldShouldClear(_ textField: UITextField) -> Bool { return onTextFieldShouldClear?(textField) ?? true }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool { return onTextFieldShouldReturn?(textField) ?? true }
}
