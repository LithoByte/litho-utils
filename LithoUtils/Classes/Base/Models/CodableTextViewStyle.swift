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
import LithoStrings

open class CodableTextViewStyle: CodableViewStyle {
    open var font: CodableFont?
    open var textColor: String?
    open var lineHeightMultiplier: CGFloat?
    
    public init(backgroundColorHex: String? = nil, tintColorHex: String? = nil, isHidden: Bool? = nil, isOpaque: Bool? = nil, clipsToBounds: Bool? = nil, alpha: CGFloat? = nil, cornerRadius: CGFloat? = nil, isRounded: Bool? = nil, borderWidth: CGFloat? = nil, borderColorHex: String? = nil, shadowColorHex: String? = nil, shadowRadius: CGFloat? = nil, shadowOpacity: Float? = nil, font: CodableFont? = nil, textColor: String? = nil, lineHeightMultiplier: CGFloat? = nil) {
        self.font = font
        self.textColor = textColor
        self.lineHeightMultiplier = lineHeightMultiplier
        super.init(backgroundColorHex: backgroundColorHex, tintColorHex: tintColorHex, isHidden: isHidden, isOpaque: isOpaque, clipsToBounds: clipsToBounds, alpha: alpha, cornerRadius: cornerRadius, isRounded: isRounded, borderWidth: borderWidth, borderColorHex: borderColorHex, shadowColorHex: shadowColorHex, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity)
    }
    
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    public override func apply(to view: UIView) {
        view |> ~>styleTextViewFunction(given: self)
    }
}

public func styleTextViewFunction(given style: CodableTextViewStyle) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = styleFunction(given: style)
    var result: (UITextView) -> Void = doNothing

    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    result <>= style.font?.setOnTextView
    
    return result
}

public func styleTextViewFunctionWithTitle(given style: CodableTextViewStyle, with title: String?) -> (UITextView) -> Void {
    let doNothing: (UITextView) -> Void = styleFunction(given: style)
    var result: (UITextView) -> Void = doNothing
    result <>= (title -*> attributedTextSetter(given: style))
    
    return result
}

public func attributedTextSetter(given style: CodableTextViewStyle) -> (UITextView, String?) -> Void {
    return { textView, text in
        let attributed = convertToMutableString(fromRegularString: text ?? "")
        style.font?.font() ?> (attributed -*> setFontAttributes)
        style.textColor ?> (UIColor.init(hexString:) >?> (attributed -*> setForegroundColorAttributes))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = style.lineHeightMultiplier ?? 1.0
        paragraphStyle |> (attributed -*> setParagraphStyleAttributes)
        textView.attributedText = attributed
    }
}
