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
    public var maskedCorners: CACornerMask?
    public var isRounded: Bool?
    public var borderWidth: CGFloat?
    public var borderColorHex: String?
    public var shadowColorHex: String?
    public var shadowRadius: CGFloat?
    public var shadowOpacity: Float?
    public var font: CodableFont?
    public var textColor: String?
    public var lineHeightMultiplier: CGFloat?
    public var lineFragmentPadding: CGFloat?
    
    public init(
        backgroundColorHex: String? = nil,
        tintColorHex: String? = nil,
        isHidden: Bool? = nil,
        isOpaque: Bool? = nil,
        clipsToBounds: Bool? = nil,
        alpha: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        maskedCorners: CACornerMask? = nil,
        isRounded: Bool? = nil,
        borderWidth: CGFloat? = nil,
        borderColorHex: String? = nil,
        shadowColorHex: String? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil,
        font: CodableFont? = nil,
        textColor: String? = nil,
        lineHeightMultiplier: CGFloat? = nil,
        lineFragmentPadding: CGFloat? = nil
    ) {
        self.backgroundColorHex = backgroundColorHex
        self.tintColorHex = tintColorHex
        self.isHidden = isHidden
        self.isOpaque = isOpaque
        self.clipsToBounds = clipsToBounds
        self.alpha = alpha
        self.cornerRadius = cornerRadius
        self.maskedCorners = maskedCorners
        self.isRounded = isRounded
        self.borderWidth = borderWidth
        self.borderColorHex = borderColorHex
        self.shadowColorHex = shadowColorHex
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.font = font
        self.textColor = textColor
        self.lineHeightMultiplier = lineHeightMultiplier
        self.lineFragmentPadding = lineFragmentPadding
    }
    
    public func apply(to view: UIView?) {
        view |> ~>styleTextViewFunction(given: self)
    }
    
    public func apply(to view: UIView?, with title: String?) {
        view |> ~>styleTextViewFunctionWithTitle(given: self, with: title)
    }
}

public func styleTextViewFunction(given style: CodableTextViewStyle) -> (UITextView?) -> Void {
    var result: (UITextView) -> Void = styleFunction(given: style)
    
    result <>= style.textColor |> (~>UIColor.init(hexString:) >>> (\UITextView.textColor *-> set))
    result <>= style.lineFragmentPadding ?> (\UITextView.textContainer.lineFragmentPadding *-> set)
    result <>= style.font?.setOnTextView
    
    return ~>result
}

public func styleTextViewFunctionWithTitle(given style: CodableTextViewStyle, with title: String?) -> (UITextView?) -> Void {
    let doNothing: (UITextView) -> Void = styleFunction(given: style)
    var result: (UITextView) -> Void = doNothing
    
    result <>= style.lineFragmentPadding ?> (\UITextView.textContainer.lineFragmentPadding *-> set)
    result <>= (title -*> attributedTextSetter(given: style))
    
    return ~>result
}

public func attributedTextSetter(given style: CodableTextViewStyle) -> (UITextView?, String?) -> Void {
    return { textView, text in
        let attributed = convertToMutableString(fromRegularString: text ?? "")
        style.font?.font() ?> (attributed -*> setFontAttributes)
        style.textColor ?> (UIColor.init(hexString:) >?> (attributed -*> setForegroundColorAttributes))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = style.lineHeightMultiplier ?? 1.0
        paragraphStyle |> (attributed -*> setParagraphStyleAttributes)
        textView?.attributedText = attributed
    }
}
