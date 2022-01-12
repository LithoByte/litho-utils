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
    open var textViewAttributedText: String?
    open var textViewFontName: String?
    open var textViewFontSize: String?
    open var textViewTextColor: String?
}

public func styleTextViewFunction(given style: CodableUITextViewStyle) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = { _ in }
    var result: (UITextView) -> Void = doNothing
    
    result <>= style.textViewAtrributedText |> (~>NSAttributedString.init(string:) >>> (\UITextView.attributedText *-> set))
//    result <>= union(style.textViewFont, style.textViewFontSize)  |> (~>UIFont.init(name:size:) >>> (\UITextView.font *-> set))
    result <>= style.textViewTextColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    return result
}
