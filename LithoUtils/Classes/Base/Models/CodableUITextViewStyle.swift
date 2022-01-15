//
//  CodableUITextViewStyle.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/12/22.
//

import Foundation
import Prelude
import LithoOperators
import UIKit

open class CodableUITextViewStyle: CodableViewStyle {
    open var textViewText: String?
    open var textViewFont: CodableFont?
    open var textViewTextColor: String?
}

public func styleTextViewFunction(given style: CodableUITextViewStyle) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = { _ in }
    var result: (UITextView) -> Void = doNothing
    
    result <>= style.textViewText |> (~>String.init(stringLiteral:) >>> (\UITextView.text *-> set))
    result <>= style.textViewTextColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    result <>= style.textViewFont?.setOnTextView
    
    return result
}
