//
//  CodableTextViewStyle.swift
//  LithoUtils
//
//  Created by Remmington Damper on 1/12/22.
//

import Foundation
import Prelude
import LithoOperators
import UIKit

open class CodableTextViewStyle: CodableViewStyle {
    open var textViewFont: CodableFont?
    open var textViewTextColor: String?
}

public func styleTextViewFunction(given style: CodableUITextViewStyle) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = { _ in }
    var result: (UITextView) -> Void = doNothing

    result <>= style.textViewTextColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    result <>= style.textViewFont?.setOnTextView
    
    return result
}
