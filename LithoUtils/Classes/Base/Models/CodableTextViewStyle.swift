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
    open var font: CodableFont?
    open var textColor: String?
}

public func styleTextViewFunction(given style: CodableTextViewStyle) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = styleFunction(given: style)
    var result: (UITextView) -> Void = doNothing

    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    result <>= style.font?.setOnTextView
    
    return result
}
