//
//  CodableUITextFieldStyle.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/12/22.
//

import Foundation
import Prelude
import LithoOperators
import UIKit

open class CodableUITextFieldStyle: CodableViewStyle {
    open var textFieldText: String?
    open var textFieldPlaceHolder: String?
    open var textFieldFont: CodableFont?
    open var textFieldTextColor: String?
    open var textFieldBorderStyle: UITextField.BorderStyle?
}

public func styleTextFieldFunction(given style: CodableUITextFieldStyle) -> (UITextField) -> Void {
    let doNothing: (UITextField) -> Void = { _ in }
    var result: (UITextField) -> Void = doNothing
    
    result <>= style.textFieldText |> (~>String.init(stringLiteral:) >>> (\UITextField.text *-> set))
    result <>= style.textFieldPlaceHolder |> (~>String.init(stringLiteral:) >>> (\UITextField.placeholder *-> set))
    result <>= style.textFieldFont?.setOnTextField
    result <>= style.textFieldTextColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    result <>= style.textFieldBorderStyle ?> (\UITextField.borderStyle *-> set)
    return result
}
