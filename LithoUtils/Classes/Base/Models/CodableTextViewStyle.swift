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
    
    public init(backgroundColorHex: String? = nil, tintColorHex: String? = nil, isHidden: Bool? = nil, isOpaque: Bool? = nil, clipsToBounds: Bool? = nil, alpha: CGFloat? = nil, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColorHex: String? = nil, shadowColorHex: String? = nil, shadowRadius: CGFloat? = nil, shadowOpacity: Float? = nil, font: CodableFont? = nil, textColor: String? = nil) {
        self.font = font
        self.textColor = textColor
        super.init(backgroundColorHex: backgroundColorHex, tintColorHex: tintColorHex, isHidden: isHidden, isOpaque: isOpaque, clipsToBounds: clipsToBounds, alpha: alpha, cornerRadius: cornerRadius, borderWidth: borderWidth, borderColorHex: borderColorHex, shadowColorHex: shadowColorHex, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
    
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

public func styleTextViewFunction(given style: CodableTextViewStyle) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = styleFunction(given: style)
    var result: (UITextView) -> Void = doNothing

    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    result <>= style.font?.setOnTextView
    
    return result
}
