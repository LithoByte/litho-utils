//
//  CodableTextFieldStyle.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/12/22.
//

import Foundation
import Prelude
import LithoOperators
import UIKit

open class CodableTextFieldStyle: CodableViewStyle {
    open var textFieldFont: CodableFont?
    open var textFieldTextColor: String?
    open var textFieldBorderStyle: UITextField.BorderStyle?
}

public func styleTextFieldFunction(given style: CodableUITextFieldStyle) -> (UITextField) -> Void {
    let doNothing: (UITextField) -> Void = { _ in }
    var result: (UITextField) -> Void = doNothing

    result <>= style.textFieldFont?.setOnTextField
    result <>= style.textFieldTextColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    result <>= style.textFieldBorderStyle ?> (\UITextField.borderStyle *-> set)
    return result
}
