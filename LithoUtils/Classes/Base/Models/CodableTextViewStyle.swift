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

open class CodableTextViewStyle: CodableViewStyleProtocol, Codable {
    public var backgroundColorHex: String?
    public var tintColorHex: String?
    public var isHidden: Bool?
    public var isOpaque: Bool?
    public var clipsToBounds: Bool?
    public var alpha: CGFloat?
    public var cornerRadius: CGFloat?
    public var isRounded: Bool?
    public var borderWidth: CGFloat?
    public var borderColorHex: String?
    public var shadowColorHex: String?
    public var shadowRadius: CGFloat?
    public var shadowOpacity: Float?
    public var font: CodableFont?
    public var textColor: String?
    public var lineHeightMultiplier: CGFloat?
    
    public func apply(to view: UIView) {
        view |> ~>styleTextViewFunction(given: self)
    }
}

public func styleTextViewFunction(given style: CodableTextViewStyle) -> (UITextView) -> Void {
    var result: (UITextView) -> Void = styleFunction(given: style)

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
