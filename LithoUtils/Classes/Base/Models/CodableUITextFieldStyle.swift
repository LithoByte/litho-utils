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
    open var textFieldAttributedText: String?
    open var textFieldAttributedTextPlaceHolder: String?
    open var textFieldFont: String?
    open var textFieldTextColor: String?
}

public func styleTextFieldFunction(given style: CodableUITextFieldStyle) -> (UITextField) -> Void {
    let doNothing: (UITextField) -> Void = { _ in }
    var result: (UITextField) -> Void = doNothing
    
    result <>= style.textFieldAttributedText |> (~>NSAttributedString.init(string:) >>> (\UITextField.attributedText *-> set))
    result <>= style.textFieldAttributedTextPlaceHolder |> (~>NSAttributedString.init(string:) >>> (\UITextField.attributedPlaceholder *-> set))
//    result <>= style.textFieldFont |> (~>UIFont.init(name:, size:) >>> (\UITextField.font *-> set))
    result <>= style.textFieldTextColor |> (~>UIColor.init(hexString:) >>> (\UITextField.textColor *-> set))
    
    return result
}
