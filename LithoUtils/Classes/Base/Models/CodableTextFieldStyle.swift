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
    open var font: CodableFont?
    open var textColor: String?
    open var borderStyle: UITextField.BorderStyle?
}

public func styleTextFieldFunction(given style: CodableTextFieldStyle) -> (UITextField) -> Void {
    let doNothing: (UITextField) -> Void = styleFunction(given: style)
    var result: (UITextField) -> Void = doNothing

    result <>= style.font?.setOnTextField
    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    result <>= style.borderStyle ?> (\UITextField.borderStyle *-> set)
    return result
}
